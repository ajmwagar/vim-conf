-- Colorscheme switcher with live preview.
--
--   :Theme            open the picker; ↑/↓ (or j/k) preview, ⏎ keeps,
--                      Esc/q restores the scheme you started from
--   :Theme <name>     apply a scheme and remember it
--   :Theme list       print installed schemes, highlighting the active one
--
-- The last confirmed scheme is stored in stdpath("state")/colorscheme and
-- restored on the next start.

local api = vim.api

local M = {}

local state_file = vim.fn.stdpath("state") .. "/colorscheme"

-- Shown first, in this order, when installed. Everything else follows
-- alphabetically.
local preferred = {
  "deus",
  "catppuccin",
  "catppuccin-mocha",
  "tokyonight",
  "tokyonight-night",
  "kanagawa",
  "kanagawa-wave",
  "gruvbox",
  "rose-pine",
  "rose-pine-main",
}

local function notify(msg, level)
  vim.notify("theme: " .. msg, level or vim.log.levels.INFO)
end

--- Every colorscheme Neovim can resolve by name, preferred ones first.
---@return string[]
local function installed()
  local seen, found = {}, {}

  for _, pattern in ipairs({ "colors/*.vim", "colors/*.lua" }) do
    for _, path in ipairs(api.nvim_get_runtime_file(pattern, true)) do
      local name = vim.fn.fnamemodify(path, ":t:r")
      if not seen[name] then
        seen[name] = true
        found[#found + 1] = name
      end
    end
  end

  table.sort(found)

  local ordered = {}
  for _, name in ipairs(preferred) do
    if seen[name] then
      ordered[#ordered + 1] = name
      seen[name] = nil
    end
  end
  for _, name in ipairs(found) do
    if seen[name] then
      ordered[#ordered + 1] = name
    end
  end
  return ordered
end

--- Apply a scheme without throwing; returns success and an optional error.
---@param name string
local function apply(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    return false, tostring(err)
  end
  return true
end

---@param name string
local function remember(name)
  pcall(vim.fn.writefile, { name }, state_file)
end

---@return string?
local function remembered()
  if vim.fn.filereadable(state_file) ~= 1 then
    return nil
  end
  local lines = vim.fn.readfile(state_file)
  local name = lines[1] and lines[1]:match("^%s*(.-)%s*$")
  return (name ~= nil and name ~= "") and name or nil
end

---@param name string
local function set(name)
  if not apply(name) then
    notify(("no colorscheme named %q"):format(name), vim.log.levels.ERROR)
    return false
  end
  remember(name)
  notify(("using %s"):format(name))
  return true
end

--- Print installed schemes; the active one is marked with "›".
function M.list()
  local active = vim.g.colors_name
  local lines = {}
  for _, name in ipairs(installed()) do
    lines[#lines + 1] = (name == active and "› " or "  ") .. name
  end
  if #lines == 0 then
    notify("no colorschemes found", vim.log.levels.WARN)
    return
  end
  if #api.nvim_list_uis() > 0 then
    vim.cmd("botright new")
    local buf = api.nvim_get_current_buf()
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype = "theme-list"
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, desc = "Close theme list" })
  else
    for _, line in ipairs(lines) do
      print(line)
    end
  end
end

--- Fallback floating picker when telescope is unavailable.
local function open_float()
  local names = installed()
  if #names == 0 then
    notify("no colorschemes found", vim.log.levels.WARN)
    return
  end

  local original = vim.g.colors_name or "deus"
  local current = 1
  for i, name in ipairs(names) do
    if name == original then
      current = i
      break
    end
  end

  local width = math.max(24, math.min(40, math.floor(#table.concat(names, " ") / #names) + 12))
  local height = math.min(#names, 14)

  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(buf, 0, -1, false, names)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false

  local win = api.nvim_open_win(buf, true, {
    relative = "editor",
    row = math.max(0, (vim.o.lines - height) / 2 - 1),
    col = math.max(0, (vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = " Colorschemes  ↑↓ preview  ⏎ apply  esc cancel ",
    title_pos = "center",
  })
  vim.wo[win].cursorline = true

  local ns = api.nvim_create_namespace("ajmwagar.theme.picker")
  local done = false

  local render = function()
    api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    api.nvim_buf_set_extmark(buf, ns, current - 1, 0, {
      line_hl_group = "PmenuSel",
    })
    api.nvim_win_set_cursor(win, { current, 0 })
  end

  local function close(confirmed)
    if done then
      return
    end
    done = true

    local chosen = names[current]
    if confirmed and apply(chosen) then
      remember(chosen)
      notify(("using %s"):format(chosen))
    else
      -- Cancelled, or the preview could not actually be loaded: go back.
      if confirmed then
        notify(("could not load %s; keeping %s"):format(chosen, original), vim.log.levels.WARN)
      end
      apply(original)
    end

    if api.nvim_win_is_valid(win) then
      api.nvim_win_close(win, true)
    end
    if api.nvim_buf_is_valid(buf) then
      pcall(api.nvim_buf_delete, buf, { force = true })
    end
  end

  local function move(delta)
    current = (current - 1 + delta) % #names + 1
    if not apply(names[current]) then
      notify(("could not load %s"):format(names[current]), vim.log.levels.WARN)
    end
    render()
  end

  local function map(lhs, fn, desc)
    vim.keymap.set("n", lhs, fn, { buffer = buf, silent = true, desc = desc })
  end

  map("<Down>", function()
    move(1)
  end, "Next scheme")
  map("<Up>", function()
    move(-1)
  end, "Previous scheme")
  map("j", function()
    move(1)
  end, "Next scheme")
  map("k", function()
    move(-1)
  end, "Previous scheme")
  map("<C-n>", function()
    move(1)
  end, "Next scheme")
  map("<C-p>", function()
    move(-1)
  end, "Previous scheme")
  map("<CR>", function()
    close(true)
  end, "Apply scheme")
  map("q", function()
    close(false)
  end, "Cancel")
  map("<Esc>", function()
    close(false)
  end, "Cancel")
  map("<C-c>", function()
    close(false)
  end, "Cancel")

  render()
end

--- Open the fuzzy picker. Selection previews immediately; only ⏎ persists.
function M.open()
  local names = installed()
  if #names == 0 then
    notify("no colorschemes found", vim.log.levels.WARN)
    return
  end

  local original = vim.g.colors_name or "deus"

  -- deus is the default: preview it as soon as the picker opens (telescope
  -- does not fire the previewer for the initial selection in this version).
  local has_deus = false
  for _, name in ipairs(names) do
    if name == "deus" then
      has_deus = true
      break
    end
  end
  if has_deus then
    apply("deus")
  end

  local ok = pcall(function()
    return require("telescope.pickers")
  end)
  if not ok then
    return open_float()
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function cancel(prompt_bufnr)
    apply(original)
    actions.close(prompt_bufnr)
  end

  local function choose(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    local name = entry and entry.value
    if name and apply(name) then
      remember(name)
      notify(("using %s"):format(name))
    elseif name then
      notify(("could not load %s; keeping %s"):format(name, original), vim.log.levels.WARN)
      apply(original)
    end
    actions.close(prompt_bufnr)
  end

  -- Applying on every selection change is the live preview.
  local previewer = {}
  function previewer:title()
    return "colorscheme preview"
  end
  function previewer:preview(entry)
    if entry and entry.value and entry.value ~= vim.g.colors_name then
      apply(entry.value)
    end
  end
  function previewer:teardown() end

  -- deus is the default selection unless the user's saved theme is installed.
  local default = nil
  for i, name in ipairs(names) do
    if name == "deus" then
      default = i
      break
    end
  end

  local opts = {}
  pickers.new(opts, {
    prompt_title = "Colorschemes (fuzzy; enter apply, esc cancel)",
    default_selection_index = default,
    finder = finders.new_table({
      results = names,
      entry_maker = function(name)
        return { value = name, display = name, ordinal = name }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = previewer,
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", choose)
      map("n", "<CR>", choose)
      map("i", "<Esc>", cancel)
      map("n", "<Esc>", cancel)
      map("i", "<C-c>", cancel)
      map("n", "<C-c>", cancel)
      map("n", "q", cancel)
      return true
    end,
  }):find()
end

--- Restore the remembered scheme; fall back silently to whatever is loaded.
function M.restore()
  local name = remembered()
  if not name or name == vim.g.colors_name then
    return
  end
  apply(name)
end

api.nvim_create_user_command("Theme", function(opts)
  local arg = opts.fargs[1]
  if arg == nil or arg == "" then
    return M.open()
  elseif arg == "list" then
    return M.list()
  end
  set(arg)
end, {
  nargs = "?",
  desc = "Preview / apply a colorscheme",
  complete = function()
    return installed()
  end,
})

vim.keymap.set("n", "<leader>tt", M.open, { silent = true, desc = "Colorscheme picker" })

M.restore()

return M
