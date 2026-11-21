-- Lisp workbench: highlighting glue, a real REPL, eval-current-form, run-file.
--
--   :Lisp              toggle the REPL (auto-detects sbcl, clisp, ecl, ccl, ros,
--                      guile, racket, csi, gosh)
--   :Lisp repl [impl]  open the REPL, optionally forcing an implementation
--   :Lisp eval         send the enclosing top-level form (or visual range)
--   :Lisp defun        same as eval; named for muscle memory
--   :Lisp buffer       load the current file into the REPL
--   :Lisp run [file]   run the file as a script, output in a scratch split
--   :Lisp stop         kill the REPL
--   :Lisp info         what was detected / what is installed
--
-- Buffer-local maps (lisp / scheme / racket files):
--   <leader>lr  toggle REPL          <leader>le  eval form / selection
--   <leader>lb  load buffer         <leader>lf  run file
--   <leader>ls  stop REPL

local api = vim.api
local uv = vim.uv or vim.loop

local M = {}

-- ---------------------------------------------------------------------------
-- Filetype gaps (built-in runtime already handles *.lisp, *.cl, *.lsp)
-- ---------------------------------------------------------------------------

vim.filetype.add({
  extension = { asd = "lisp", ros = "lisp", soil = "lisp", bel = "lisp" },
  pattern = {
    [".*%.sbclrc"] = "lisp",
    [".*%.clisprc"] = "lisp",
    [".*%.eclrc"] = "lisp",
  },
})

-- File arguments can be opened before filetype detection is enabled, and
-- vim-polyglot's ftdetect files only cover *.lisp, so claim these extensions
-- explicitly. (vim.filetype.add above still serves :filetype detect.)
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = api.nvim_create_augroup("ajmwagar.lisp_filetypes", { clear = true }),
  pattern = { "*.asd", "*.ros", "*.soil", "*.bel", "*.sbclrc", "*.clisprc", "*.eclrc" },
  callback = function(args)
    if vim.bo[args.buf].filetype == "" then
      vim.bo[args.buf].filetype = "lisp"
    end
  end,
})

-- ---------------------------------------------------------------------------
-- Implementations
-- ---------------------------------------------------------------------------

-- Each implementation advertises the filetypes it can serve, its interactive
-- command, and how to run a file as a script.
local runtimes = {
  {
    name = "sbcl",
    exe = "sbcl",
    kinds = { "lisp" },
    repl = { "sbcl", "--noinform" },
    script = function(path)
      return { "sbcl", "--script", path }
    end,
  },
  {
    name = "clisp",
    exe = "clisp",
    kinds = { "lisp" },
    repl = { "clisp", "-q" },
    script = function(path)
      return { "clisp", "-q", path }
    end,
  },
  {
    name = "ecl",
    exe = "ecl",
    kinds = { "lisp" },
    repl = { "ecl" },
    script = function(path)
      return { "ecl", "--shell", path }
    end,
  },
  {
    name = "ccl",
    exe = "ccl",
    kinds = { "lisp" },
    repl = { "ccl", "--no-init" },
    script = function(path)
      return { "ccl", "--load", path, "--eval", "(ccl:quit)" }
    end,
  },
  {
    name = "ros",
    exe = "ros",
    kinds = { "lisp" },
    repl = { "ros", "run" },
    script = function(path)
      return { "ros", "run", path }
    end,
  },
  {
    name = "guile",
    exe = "guile",
    kinds = { "scheme" },
    repl = { "guile", "--no-auto-compile" },
    script = function(path)
      return { "guile", "--no-auto-compile", path }
    end,
  },
  {
    name = "racket",
    exe = "racket",
    kinds = { "scheme", "racket" },
    repl = { "racket" },
    script = function(path)
      return { "racket", path }
    end,
  },
  {
    name = "chicken",
    exe = "csi",
    kinds = { "scheme" },
    repl = { "csi" },
    script = function(path)
      return { "csi", "-s", path }
    end,
  },
  {
    name = "gauche",
    exe = "gosh",
    kinds = { "scheme" },
    repl = { "gosh", "-i" },
    script = function(path)
      return { "gosh", path }
    end,
  },
}

local function contains(list, value)
  for _, item in ipairs(list) do
    if item == value then
      return true
    end
  end
  return false
end

local function kind_for(ft)
  if ft == "racket" then
    return "racket"
  elseif ft == "scheme" or ft == "chicken" then
    return "scheme"
  end
  return "lisp"
end

local function executable(rt)
  return vim.fn.executable(rt.exe) == 1
end

local function pick_runtime(kind, wanted)
  for _, rt in ipairs(runtimes) do
    if (wanted == nil or rt.name == wanted) and contains(rt.kinds, kind) and executable(rt) then
      return rt
    end
  end
end

-- ---------------------------------------------------------------------------
-- REPL plumbing
-- ---------------------------------------------------------------------------

M.repl = { buf = nil, chan = nil, runtime = nil }

local function notify(msg, level)
  vim.notify("lisp: " .. msg, level or vim.log.levels.INFO)
end

local function repl_alive()
  local st = M.repl
  return st.buf ~= nil
    and st.chan ~= nil
    and api.nvim_buf_is_valid(st.buf)
    and next(api.nvim_get_chan_info(st.chan)) ~= nil
end

local function find_repl_win(buf)
  for _, win in ipairs(api.nvim_list_wins()) do
    if api.nvim_win_get_buf(win) == buf then
      return win
    end
  end
end

local function repl_height()
  return math.max(8, math.floor(vim.o.lines * 0.35))
end

local function spawn_repl(rt)
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_name(buf, ("lisp://%s"):format(rt.name))
  vim.cmd(("botright %dsplit"):format(repl_height()))
  local win = api.nvim_get_current_win()
  api.nvim_win_set_buf(win, buf)

  local chan = vim.fn.termopen(rt.repl, {
    cwd = vim.fn.getcwd(),
    on_exit = function(_, code)
      vim.schedule(function()
        if M.repl.buf ~= buf then
          return -- a newer REPL replaced this one
        end
        M.repl.buf, M.repl.chan, M.repl.runtime = nil, nil, nil
        if api.nvim_buf_is_valid(buf) then
          local ok = pcall(api.nvim_buf_set_lines, buf, -1, -1, false, {
            (";; %s exited (%d)"):format(rt.name, code),
          })
          if ok then
            vim.bo[buf].modifiable = false
          end
        end
      end)
    end,
  })

  if chan <= 0 then
    notify(("could not start %s"):format(rt.name), vim.log.levels.ERROR)
    pcall(api.nvim_buf_delete, buf, { force = true })
    return nil
  end

  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].swapfile = false
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { buffer = buf, desc = "Leave terminal mode" })

  M.repl = { buf = buf, chan = chan, runtime = rt }
  if #api.nvim_list_uis() > 0 then
    vim.cmd("startinsert")
  end
  return M.repl
end

local function ensure_repl(ft, wanted)
  local kind = kind_for(ft)

  if repl_alive() then
    local current = M.repl.runtime
    if wanted == nil or (current and current.name == wanted) then
      return M.repl
    end
    M.stop()
  end

  local rt = pick_runtime(kind, wanted)
  if not rt then
    notify(("no %s implementation found; `:Lisp info` lists what is probed"):format(kind), vim.log.levels.WARN)
    return nil
  end
  return spawn_repl(rt)
end

local function send(text, ft, wanted)
  local st = ensure_repl(ft or vim.bo.filetype, wanted)
  if not st then
    return false
  end
  text = text:gsub("\n+$", "")
  if text == "" then
    return false
  end
  api.nvim_chan_send(st.chan, text .. "\n")
  return true
end

-- ---------------------------------------------------------------------------
-- Form extraction
-- ---------------------------------------------------------------------------

local function skip_string(text, i)
  local n = #text
  i = i + 1
  while i <= n do
    local c = text:sub(i, i)
    if c == "\\" then
      i = i + 2
    elseif c == '"' then
      return i + 1
    else
      i = i + 1
    end
  end
  return n + 1
end

local function skip_block_comment(text, i)
  local n = #text
  local depth = 0
  while i <= n do
    local two = text:sub(i, i + 1)
    if two == "#|" then
      depth = depth + 1
      i = i + 2
    elseif two == "|#" then
      depth = depth - 1
      i = i + 2
      if depth == 0 then
        return i
      end
    else
      i = i + 1
    end
  end
  return n + 1
end

-- Top-level forms as {start, stop} byte offsets into text.
local function top_level_forms(text)
  local forms = {}
  local n = #text
  local i, depth, start = 1, 0, nil
  while i <= n do
    local c = text:sub(i, i)
    if c == '"' then
      i = skip_string(text, i)
    elseif c == ";" then
      i = (text:find("\n", i, true) or n) + 1
    elseif c == "#" and text:sub(i + 1, i + 1) == "|" then
      i = skip_block_comment(text, i)
    elseif c == "#" and text:sub(i + 1, i + 1) == "\\" then
      i = i + 3 -- #\x character literal
    elseif c == "(" then
      if depth == 0 then
        start = i
      end
      depth = depth + 1
      i = i + 1
    elseif c == ")" then
      depth = math.max(0, depth - 1)
      i = i + 1
      if depth == 0 and start then
        forms[#forms + 1] = { start, i - 1 }
        start = nil
      end
    else
      i = i + 1
    end
  end
  return forms
end

local function buffer_text(buf)
  local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
  return table.concat(lines, "\n"), lines
end

-- Offset of (row, col) in the joined buffer text.
local function cursor_offset(lines, row, col)
  local offset = 0
  for i = 1, row - 1 do
    offset = offset + #lines[i] + 1
  end
  return offset + col + 1 -- 1-based position of the character under the cursor
end

local function slice(text, first, last)
  local start_line = select(2, text:sub(1, first):gsub("\n", "")) + 1
  local end_line = select(2, text:sub(1, last):gsub("\n", "")) + 1
  return text:sub(first, last), start_line, end_line
end

--- Text of the enclosing top-level form at the cursor, or the current line.
function M.current_form()
  local buf = api.nvim_get_current_buf()
  local text, lines = buffer_text(buf)
  local row, col = unpack(api.nvim_win_get_cursor(0))
  local offset = cursor_offset(lines, row, col)

  local chosen
  for _, form in ipairs(top_level_forms(text)) do
    if form[1] <= offset and offset <= form[2] then
      chosen = form
      break
    end
  end

  if not chosen then
    local line = lines[row]
    if line and line:match("%S") and not line:match("^%s*;") then
      return line:match("^%s*(.-)%s*$")
    end
    return nil
  end

  local form, first, last = slice(text, chosen[1], chosen[2])
  return form, first, last
end

-- ---------------------------------------------------------------------------
-- Commands
-- ---------------------------------------------------------------------------

--- Open (and focus) the REPL, spawning it when needed.
function M.open_repl(opts)
  opts = opts or {}
  local st = ensure_repl(vim.bo.filetype, opts.runtime)
  if not st then
    return
  end
  local win = find_repl_win(st.buf)
  if win then
    api.nvim_set_current_win(win)
  else
    vim.cmd(("botright %dsplit"):format(repl_height()))
    api.nvim_win_set_buf(api.nvim_get_current_win(), st.buf)
  end
  if #api.nvim_list_uis() > 0 then
    vim.cmd("startinsert")
  end
end

--- Hide the REPL window (the process keeps running). Spawn if absent.
function M.toggle_repl(opts)
  if repl_alive() then
    local win = find_repl_win(M.repl.buf)
    if win then
      api.nvim_win_close(win, false)
      return
    end
  end
  M.open_repl(opts)
end

--- Kill the REPL process and scratch buffer.
function M.stop()
  local st = M.repl
  if not st.buf then
    notify("no REPL running")
    return
  end
  if st.chan then
    pcall(vim.fn.jobstop, st.chan)
  end
  local buf = st.buf
  local win = find_repl_win(buf)
  if win then
    api.nvim_win_close(win, false)
  end
  if api.nvim_buf_is_valid(buf) then
    pcall(api.nvim_buf_delete, buf, { force = true })
  end
  M.repl = { buf = nil, chan = nil, runtime = nil }
end

--- Send the visual selection to the REPL.
function M.eval_selection()
  local first, last = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
  if first == 0 or last == 0 then
    return
  end
  if first > last then
    first, last = last, first
  end
  local lines = api.nvim_buf_get_lines(0, first - 1, last, false)
  if send(table.concat(lines, "\n")) then
    notify("sent selection")
  end
end

--- Send the enclosing top-level form (or line, or visual range) to the REPL.
function M.eval_form()
  local mode = api.nvim_get_mode().mode
  if mode == "v" or mode == "V" or mode == "\22" then
    return M.eval_selection()
  end
  local form = M.current_form()
  if not form then
    notify("nothing to evaluate here", vim.log.levels.WARN)
    return
  end
  if send(form) then
    notify("sent form")
  end
end

--- Load the current file into the REPL.
function M.load_buffer()
  local path = api.nvim_buf_get_name(0)
  if path == "" then
    notify("buffer has no file name; use :Lisp eval", vim.log.levels.WARN)
    return
  end
  if vim.bo.modified then
    notify("buffer has unsaved changes; :write first", vim.log.levels.WARN)
    return
  end
  local escaped = path:gsub("\\", "\\\\"):gsub('"', '\\"')
  if send(('(load "%s")'):format(escaped)) then
    notify(("loading %s"):format(vim.fn.fnamemodify(path, ":t")))
  end
end

--- Run the file as a standalone script, streaming output into a scratch split.
function M.run_file(path, wanted)
  path = path or api.nvim_buf_get_name(0)
  if path == "" then
    notify("save the buffer first", vim.log.levels.WARN)
    return
  end
  path = vim.fn.fnamemodify(path, ":p")
  if vim.fn.filereadable(path) == 0 then
    notify(("cannot read %s"):format(path), vim.log.levels.WARN)
    return
  end

  local rt = pick_runtime(kind_for(vim.bo.filetype), wanted)
  if not rt then
    notify("no implementation found; `:Lisp info` lists what is probed", vim.log.levels.WARN)
    return
  end

  local out = api.nvim_create_buf(false, true)
  api.nvim_buf_set_name(out, "lisp://run")
  vim.cmd(("botright %dsplit"):format(repl_height()))
  local win = api.nvim_get_current_win()
  api.nvim_win_set_buf(win, out)
  vim.bo[out].buftype = "nofile"
  vim.bo[out].bufhidden = "wipe"
  vim.bo[out].swapfile = false
  vim.bo[out].modifiable = true
  vim.keymap.set("n", "q", function()
    api.nvim_win_close(win, false)
  end, { buffer = out, silent = true, desc = "Close run output" })

  local started = uv.hrtime()
  local remainder = { "", "" }

  local function append(kind, data)
    if not data or #data == 0 or not api.nvim_buf_is_valid(out) then
      return
    end
    local lines = vim.deepcopy(data)
    lines[1] = remainder[kind] .. lines[1]
    remainder[kind] = table.remove(lines)
    if #lines == 0 then
      return
    end
    pcall(api.nvim_buf_set_lines, out, -1, -1, false, lines)
    if api.nvim_win_is_valid(win) and api.nvim_win_get_buf(win) == out then
      api.nvim_win_set_cursor(win, { math.max(1, api.nvim_buf_line_count(out)), 0 })
    end
  end

  local job = vim.fn.jobstart(rt.script(path), {
    cwd = vim.fn.fnamemodify(path, ":h"),
    on_stdout = function(_, data)
      append(1, data)
    end,
    on_stderr = function(_, data)
      append(2, data)
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        if not api.nvim_buf_is_valid(out) then
          return
        end
        for k = 1, 2 do
          if remainder[k] ~= "" then
            pcall(api.nvim_buf_set_lines, out, -1, -1, false, { remainder[k] })
            remainder[k] = ""
          end
        end
        local ms = (uv.hrtime() - started) / 1e6
        pcall(api.nvim_buf_set_lines, out, -1, -1, false, {
          (";; %s exited with %d in %.0f ms"):format(rt.name, code, ms),
        })
        vim.bo[out].modifiable = false
      end)
    end,
  })

  if job <= 0 then
    notify(("could not run %s"):format(rt.name), vim.log.levels.ERROR)
    pcall(api.nvim_buf_delete, out, { force = true })
    return
  end

  notify(("running %s with %s"):format(vim.fn.fnamemodify(path, ":t"), rt.name))
end

function M.info()
  local kind = kind_for(vim.bo.filetype)
  local lines = { ("filetype %s -> %s dialect"):format(vim.bo.filetype, kind), "" }
  for _, rt in ipairs(runtimes) do
    local mark = executable(rt) and "found" or "missing"
    if contains(rt.kinds, kind) then
      mark = mark .. " (candidate)"
    end
    lines[#lines + 1] = ("  %-8s %-18s %s"):format(rt.name, rt.exe, mark)
  end
  local active = repl_alive() and ("running: " .. M.repl.runtime.name) or "no REPL running"
  lines[#lines + 1] = ""
  lines[#lines + 1] = active
  if not pick_runtime(kind) then
    lines[#lines + 1] = ""
    lines[#lines + 1] = "install one, e.g.:  brew install sbcl"
  end
  vim.notify(table.concat(lines, "\n"))
end

local subcommands = { "repl", "eval", "defun", "buffer", "run", "stop", "info" }

api.nvim_create_user_command("Lisp", function(opts)
  local sub = (opts.fargs[1] or ""):lower()
  local arg = opts.fargs[2]

  if sub == "" then
    return M.toggle_repl()
  elseif sub == "repl" then
    return M.open_repl({ runtime = arg })
  elseif sub == "eval" or sub == "defun" then
    if opts.range > 0 then
      local lines = api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
      if send(table.concat(lines, "\n")) then
        notify("sent selection")
      end
      return
    end
    return M.eval_form()
  elseif sub == "buffer" then
    return M.load_buffer()
  elseif sub == "run" then
    return M.run_file(arg, nil)
  elseif sub == "stop" then
    return M.stop()
  elseif sub == "info" then
    return M.info()
  end
  notify(("unknown subcommand %q"):format(sub), vim.log.levels.ERROR)
end, {
  nargs = "*",
  range = true,
  desc = "Lisp REPL / runner",
  complete = function(_, line)
    local parts = vim.split(line, "%s+", { trimempty = true })
    if #parts <= 2 then
      return vim.tbl_filter(function(c)
        return c:find(parts[2] or "", 1, true) == 1
      end, subcommands)
    end
    return {}
  end,
})

-- ---------------------------------------------------------------------------
-- Buffer-local conveniences for lisp-ish filetypes
-- ---------------------------------------------------------------------------

local group = api.nvim_create_augroup("ajmwagar.lisp", { clear = true })

api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "lisp", "scheme", "racket", "chicken" },
  callback = function(args)
    local buf = args.buf
    local function bmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
    end

    bmap("n", "<leader>lr", function()
      M.toggle_repl()
    end, "Lisp: toggle REPL")
    bmap("n", "<leader>le", function()
      M.eval_form()
    end, "Lisp: eval form")
    bmap("x", "<leader>le", function()
      M.eval_selection()
    end, "Lisp: eval selection")
    bmap("n", "<leader>lb", function()
      M.load_buffer()
    end, "Lisp: load buffer")
    bmap("n", "<leader>lf", function()
      M.run_file()
    end, "Lisp: run file")
    bmap("n", "<leader>ls", function()
      M.stop()
    end, "Lisp: stop REPL")

    -- Prefer the tree-sitter parser when it is built; otherwise the bundled
    -- regex syntax file stays in charge.
    if pcall(vim.treesitter.language.add, "commonlisp") then
      pcall(vim.treesitter.start, buf, "commonlisp")
    end
  end,
})

return M
