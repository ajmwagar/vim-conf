-- For a paranoia.
-- Normally `:set nocp` is not needed, because it is done automatically
-- when .vimrc is found.
if vim.opt.compatible then
    -- `:set nocp` has many side effects. Therefore this should be done
    -- only when 'compatible' is set.
    vim.opt.compatible = false;
end

-- Disable default plugins:
vim.g.loaded_matchit = 1; -- Don't need it
vim.g.loaded_gzip = 1; -- Gzip is pointless
vim.g.loaded_zipPlugin = 1; -- zip is also pointless
vim.g.loaded_logipat = 1; -- No logs
vim.g.loaded_2html_plugin = 1; -- Disable 2html
vim.g.loaded_rrhelper = 1; -- I don't use r
vim.g.loaded_getscriptPlugin = 1; -- Dont need it
vim.g.loaded_tarPlugin = 1; -- Nope
