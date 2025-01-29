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
require('config.oil')

-- Setup fzf-lua
require('config.fzf-lua')

-- Setup the TreeSitter
require('config.treesitter')

-- Other options
vim.opt.laststatus = 2
vim.opt.signcolumn = "no"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.splitbelow = true

----------------------------------------------------------------------------------------
--                                  Keybindings                                       --
----------------------------------------------------------------------------------------

-- Map '==' to resize all Vim-splits equally
vim.keymap.set("n", "==", "<C-w>=", { silent = true, noremap = true })

-- Map '-' key to '/' for fast searches
vim.keymap.set("n", "-", "/", { noremap = true })

-- No highlight
vim.keymap.set("n", "<leader>n", ":noh<CR>", { silent = true })

-- No yank on delete. Use <Leader+d> to remove and yank
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("x", "d", '"_d', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("x", "x", '"_x', { noremap = true })
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("x", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
vim.keymap.set("x", "C", '"_C', { noremap = true })
vim.keymap.set("n", "<leader>d", '""d', { noremap = true })
vim.keymap.set("x", "<leader>d", '""d', { noremap = true })

-- Jump 20 characters with K and J
vim.keymap.set("n", "K", "20k", { noremap = true })
vim.keymap.set("v", "K", "20k", { noremap = true })
vim.keymap.set("n", "J", "20j", { noremap = true })
vim.keymap.set("v", "J", "20j", { noremap = true })

-- Use <Ctrl+c/x> to copy/cut into register + when in visual mode
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true })
vim.keymap.set("v", "<C-x>", '"+d', { noremap = true })

-- Create new (empty) splits (tmux-like)
vim.keymap.set("n", "<M-I>", ":vnew<CR>", { noremap = true })
vim.keymap.set("n", "<M-U>", ":new<CR>", { noremap = true })

-- Move current split to the far right/left (i3-like)
vim.keymap.set("n", "<M-Ö>", "<C-W>L", { noremap = true })
vim.keymap.set("n", "<M-J>", "<C-W>H", { noremap = true })
vim.keymap.set("n", "<M-K>", "<C-W>J", { noremap = true })
vim.keymap.set("n", "<M-L>", "<C-W>K", { noremap = true })
