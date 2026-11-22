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
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- Colorschemes (preview/switch with :Theme, see ajmwagar/theme.lua)
    use { 'catppuccin/nvim', tag = 'v1.9.0' } -- newer tags need vim.pack (nvim 0.13)
    use 'folke/tokyonight.nvim'
    use 'rebelot/kanagawa.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use { 'rose-pine/neovim', as = 'rose-pine' }

    -- Syntax Highlighting
    use 'sheerun/vim-polyglot' -- Syntax highlighting collection
    use 'ussrlongbow/vim-sqf' -- SQF Syntax highlighting

    use 'jiangmiao/auto-pairs' -- Autoclose brackets and ''
    use 'tpope/vim-commentary' -- Toggle comments with ease
    use 'tpope/vim-fugitive'

    -- UI
    use 'itchyny/lightline.vim'
    use 'mengelbrecht/lightline-bufferline'
    use 'ajmwagar/vim-deus'
    use 'ajmwagar/lightline-deus'


    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use({
      'glepnir/galaxyline.nvim',
      branch = 'main',
      -- some optional icons
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-ui-select.nvim' }

    use {
        'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }
    }
end)
