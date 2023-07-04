local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..." vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	requires = {
	-- LSP Support
		{'neovim/nvim-lspconfig'},             -- Required
		{                                      -- Optional
		'williamboman/mason.nvim',
		run = function()
			pcall(vim.cmd, 'MasonUpdate')
		end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required
		{'hrsh7th/cmp-buffer'},
		{'rafamadriz/friendly-snippets'}, -- a bunch of snippets to use
		{'hrsh7th/cmp-path'},
		{'L3MON4D3/LuaSnip'}, --snippet engine
		{'saadparwaiz1/cmp_luasnip'}, -- snippet completions
		{'hrsh7th/cmp-cmdline'},
		{'hrsh7th/cmp-nvim-lua'}
	}
}
use "nvim-telescope/telescope.nvim"
use 'nvim-telescope/telescope-media-files.nvim'
use "nvim-treesitter/nvim-treesitter"
use "windwp/nvim-autopairs"
use "lukas-reineke/indent-blankline.nvim"
use "kyazdani42/nvim-tree.lua"
use "kyazdani42/nvim-web-devicons"
use "akinsho/bufferline.nvim"
use "akinsho/toggleterm.nvim"
use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
use "ahmedkhalf/project.nvim"
use "goolord/alpha-nvim"
use "moll/vim-bbye"
use "norcalli/nvim-colorizer.lua"
use "dstein64/vim-startuptime"
use "ThePrimeagen/harpoon"
use "jose-elias-alvarez/null-ls.nvim"
use 'Exafunction/codeium.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
