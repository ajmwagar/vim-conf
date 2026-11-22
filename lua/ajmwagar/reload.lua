-- Config reloading.
--
--   :Reload    re-source init.lua in place, keeping buffers and windows.
--              Config modules are dropped from package.loaded first, so edits
--              to lua/ajmwagar/*.lua are picked up too.
--   :Reload!   save a session, kill this Neovim and reopen it in the same
--              tmux pane. Refuses if any buffer has unsaved changes.
--
-- <leader>rr and <leader>rR are the same two commands.

local api = vim.api

local M = {}

local function notify(msg, level)
  vim.notify("reload: " .. msg, level or vim.log.levels.INFO)
end

local function init_path()
  local myvimrc = vim.env.MYVIMRC
  if myvimrc and myvimrc ~= "" then
    return myvimrc
  end
  return vim.fn.stdpath("config") .. "/init.lua"
end

--- Re-source the config without restarting Neovim.
function M.soft()
  local path = init_path()
  if vim.fn.filereadable(path) == 0 then
    notify(("cannot find %s"):format(path), vim.log.levels.ERROR)
    return
  end

  -- require() caches modules. Clear only the config modules that are safe to
  -- execute twice; plugin setup modules (lsp, cmp, plugins/packer) are not
  -- idempotent and stay cached — use :Reload! for those.
  local reloadable = {
    "misc",
    "options",
    "colors",
    "keybinds",
    "statusline",
    "lisp",
    "theme",
    "reload",
  }
  for _, mod in ipairs(reloadable) do
    package.loaded["ajmwagar." .. mod] = nil
  end

  local ok, err = pcall(vim.cmd.source, vim.fn.fnameescape(path))
  if not ok then
    notify(("failed: %s"):format(err), vim.log.levels.ERROR)
    return
  end

  vim.cmd("redraw")
  notify(("reloaded %s"):format(vim.fn.fnamemodify(path, ":~")))
end

--- Quote a string for POSIX sh.
local function sh_quote(value)
  return "'" .. value:gsub("'", "'\\''") .. "'"
end

--- @return string[] modified, non-scratch buffers
local function modified_buffers()
  local dirty = {}
  for _, buf in ipairs(api.nvim_list_bufs()) do
    if vim.bo[buf].modified and vim.bo[buf].buftype == "" and vim.bo[buf].buflisted then
      dirty[#dirty + 1] = vim.fn.fnamemodify(api.nvim_buf_get_name(buf), ":~:.")
    end
  end
  return dirty
end

--- Save buffers/tabs/windows to a session file.
local function save_session()
  local dir = vim.fn.stdpath("state") .. "/sessions"
  vim.fn.mkdir(dir, "p")
  local path = dir .. "/reload.vim"

  local saved = vim.o.sessionoptions
  vim.o.sessionoptions = "buffers,tabpages,winsize,winpos,terminal"
  local ok, err = pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(path))
  vim.o.sessionoptions = saved

  if not ok then
    return nil, err
  end
  return path
end

--- Kill and reopen Neovim, restoring the session, inside the current tmux pane.
function M.hard()
  local dirty = modified_buffers()
  if #dirty > 0 then
    notify(("%d modified buffer(s), save first: %s"):format(#dirty, table.concat(dirty, ", ")), vim.log.levels.WARN)
    return
  end

  local session, err = save_session()
  if not session then
    notify(("could not save session: %s"):format(err), vim.log.levels.ERROR)
    return
  end

  if not (vim.env.TMUX and vim.env.TMUX_PANE) or vim.fn.executable("tmux") == 0 then
    notify(
      ("not inside tmux; session saved to %s — restart with `nvim -S %s`"):format(session, session),
      vim.log.levels.WARN
    )
    return
  end

  -- tmux respawns the pane with this script, which inherits the pane's tty.
  local script = vim.fn.tempname()
  local lines = {
    "#!/bin/sh",
    "cd " .. sh_quote(vim.fn.getcwd()),
    "exec " .. sh_quote(vim.v.progpath) .. " -S " .. sh_quote(session),
  }
  vim.fn.writefile(lines, script)
  vim.fn.setfperm(script, "rwx------")

  local job = vim.fn.jobstart({ "tmux", "respawn-pane", "-k", "-t", vim.env.TMUX_PANE, script }, { detach = true })
  if job <= 0 then
    notify("could not ask tmux to respawn the pane", vim.log.levels.ERROR)
  end
end

api.nvim_create_user_command("Reload", function(opts)
  if opts.bang then
    M.hard()
  else
    M.soft()
  end
end, {
  bang = true,
  desc = "Reload the config (:Reload! restarts Neovim via tmux)",
})

vim.keymap.set("n", "<leader>rr", M.soft, { silent = true, desc = "Reload config" })
vim.keymap.set("n", "<leader>rR", M.hard, { silent = true, desc = "Restart Neovim (tmux)" })

return M
