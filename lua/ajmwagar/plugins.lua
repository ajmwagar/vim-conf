-- This file can be loaded by calling `lua require('lua.plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Plugins

    -- LSP
    use "williamboman/nvim-lsp-installer"
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

    -- Syntax Highlighting
    use 'sheerun/vim-polyglot' -- Syntax highlighting collection
    use 'ussrlongbow/vim-sqf' -- SQF Syntax highlighting

    use 'jiangmiao/auto-pairs' -- Autoclose brackets and ''
    use 'tpope/vim-commentary' -- Toggle comments with ease
    use 'tpope/vim-fugitive'

    -- UI
    use 'ajmwagar/vim-deus'
    use 'ajmwagar/lightline-deus'

    use 'itchyny/lightline.vim'
    use 'mengelbrecht/lightline-bufferline'

    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Use specific branch, dependency and run lua file after load
    --[[use {
        'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    ]]--

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Use dependency and run lua function after load
    use {
        'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
    }
end)
