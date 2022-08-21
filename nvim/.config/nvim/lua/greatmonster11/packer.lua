-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope and friends
    use("nvim-telescope/telescope.nvim")
    use { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    -- Lsp and completion
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")

    -- For luasnip users
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Ability to customize your own colorscheme
    use { 'tjdevries/colorbuddy.vim' }
    use { 'norcalli/nvim-colorizer.lua' }

    -- Colorscheme
    use { 'folke/tokyonight.nvim' }
    use { 'gruvbox-community/gruvbox' } -- My keyboard is glorious
    use { 'tjdevries/gruvbuddy.nvim' }

    -- Productive things
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'rcarriga/nvim-notify' }
    use "kyazdani42/nvim-web-devicons"

    -- Statusline
    use { 'tjdevries/express_line.nvim' }
    use { 'j-hui/fidget.nvim' }

    -- I don't know
    use {
        "ericpubu/lsp_codelens_extensions.nvim",
        config = function()
            require("codelens_extensions").setup()
        end,
    }
    use "jose-elias-alvarez/null-ls.nvim"
    use "onsails/lspkind-nvim"

end)
