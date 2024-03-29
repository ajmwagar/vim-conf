-- Set leader
vim.g.mapleader = ';'

-- Helper functions
function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map("n", shortcut, command)
end

function imap(shortcut, command)
  map("i", shortcut, command)
end

function xmap(shortcut, command)
  map("x", shortcut, command)
end

-- Keybinds

nmap("j", "gj")
nmap("k", "gk")

-- Switching buffers
nmap("<leader>[", ":bp<return>")
nmap("<leader>]", ":bn<return>")

-- Disable ex-mode
nmap("Q", "<nop>")

-- Find and replace
nmap("<leader>fr", ":%s///g<left><left>")
-- Find and replace on current line only
nmap("<leader>frl", ":s///g<left><left>")
nmap("<leader><space>", ":let @/=''<cr>") -- clear search

-- Don't lose selection when shifting sidewards
xmap("<", "<gv")
xmap(">", ">gv")

--  Telescope
nmap("<C-p>", require('telescope.builtin').find_files)
nmap("<C-t>", require('telescope.builtin').live_grep)
nmap("<C-b>", require('telescope.builtin').buffers)
nmap("<C-d>", require('telescope.builtin').diagnostics)
nmap("<C-f>", require('telescope.builtin').treesitter)
nmap("<C-q>", require('telescope.builtin').quickfix)
nmap("z=", require('telescope.builtin').spell_suggest)

-- Diagnostics
-- Use `[c` and `]c` for navigate diagnostics
nmap("]c", vim.diagnostic.goto_next)
nmap("[c", vim.diagnostic.goto_prev)


require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "^node_modules/",
            "^target/",
            "^build/",
        }
    }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
require('gitsigns').setup()

