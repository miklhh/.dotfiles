--
-- Brand new vim configuration
-- Author: Mikael Henriksson (2025)
--

-- Enable Lua loader byte-compilation caching
vim.loader.enable()

-- Disable built-in nvim netrw plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Map the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazy plugin manager
require('config.lazy')

-- Setup LSP keybinds
require('config.lsp-keybinds')

-- Setup the Oil file manager
--require('config.oil')

-- Setup fzf-lua
require('config.fzf-lua')

-- Setup the TreeSitter
require('config.treesitter')

-- Other settings
vim.opt.laststatus = 2
vim.opt.signcolumn = "no"
vim.opt.number = true
vim.opt.relativenumber = true
