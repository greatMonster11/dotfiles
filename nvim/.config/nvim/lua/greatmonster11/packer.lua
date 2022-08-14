-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope and friends
  use("nvim-telescope/telescope.nvim")
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

  -- Colorscheme
  use { 'folke/tokyonight.nvim' }
  use { 'gruvbox-community/gruvbox' } -- My keyboard is glorious

  -- Productive things
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
end)
