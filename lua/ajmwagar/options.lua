-- Disable swap files
vim.opt.swapfile = false;

-- Folding
vim.opt.foldmethod = "marker";
vim.opt.foldlevel = 0;

-- Line numbers
vim.opt.number = true; -- Enable line numbers
vim.opt.relativenumber = true; -- Enable 'nybrid' line numbers

vim.opt.mouse = "n"; -- Disable mouse in insert mode.

-- Whitespace
vim.opt.wrap = true; -- Wrap lines
vim.opt.linebreak = true; -- Wrap lines on words
vim.opt.breakindent = true; -- Consistently indent wrapped lines
vim.opt.expandtab = true; -- Use spaces not tabs
vim.opt.autoindent = true; 
vim.opt.shiftround = false; -- Indent lines by 2, not nearest multiple of 2
vim.opt.softtabstop = 2; -- Number of spaces per tab
vim.opt.shiftwidth = 2; -- Number of autoindent and shift spaces

-- Performance
vim.opt.hidden = true; -- Allow hidden buffers
vim.opt.ttyfast = true; -- Fast rendering

-- Searching
vim.opt.hlsearch = true; -- Highlight all search results
vim.opt.incsearch = true; -- Search strings incrementally
vim.opt.smartcase = true;
vim.opt.ignorecase = true;
vim.opt.showmatch = true; -- Show matching brace.

-- From COC - TODO: See if necessary
-- Better display for messages
vim.opt.cmdheight = 1;
vim.opt.showmode = false;
vim.opt.ruler = false;
vim.opt.showcmd = false;

-- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.updatetime = 100;

-- don't give |ins-completion-menu| messages.
vim.opt.shortmess = 'c';

--always show signcolumns
vim.opt.signcolumn = 'yes';

-- Make vim more natural
vim.opt.splitbelow = true; -- Split new panes below
vim.opt.splitright = true; -- Vertical split new panes to the right
