--
-- Brand new NeoVim configuration
-- Author: Mikael Henriksson (2025)
--

-- Enable Lua loader byte-compilation caching
if vim.loader then
    vim.loader.enable()
end

-- Disable built-in nvim netrw plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Map the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set termguicolors
vim.opt.termguicolors = true

----------------------------------------------------------------------------------------
--                              Plugins, LSP, Treesitter                              --
----------------------------------------------------------------------------------------

-- Lazy plugin manager (plugin configuration directory: `~/.config/nvim/lua/plugins`)
require('config.lazy')

-- Setup the Oil file manager
require('config.oil')

-- Setup fzf-lua
require('config.fzf-lua')

----------------------------------------------------------------------------------------
--                               Options and apperance                                --
----------------------------------------------------------------------------------------

-- Colorscheme
vim.cmd([[colorscheme cyberdream]])

-- Global options
vim.opt.autoread = true
vim.opt.colorcolumn = "88"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.showmode = true
vim.opt.signcolumn = "no"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.textwidth = 88
vim.opt.wrap = false

-- Profiling support
function START_PROFILE (output_file)
    require("plenary.profile").start(output_file, { flame = true })
end
function STOP_PROFILE ()
    require("plenary.profile").stop()
end


----------------------------------------------------------------------------------------
--                                    Keybindings                                     --
----------------------------------------------------------------------------------------

-- Invert relativenumber
vim.keymap.set("n", "<C-L><C-L>", "<CMD>set invrelativenumber<CR>")

-- Resize all Vim-splits equally
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

-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>i",   vim.lsp.buf.hover)
vim.keymap.set("n", "<space>lR",  vim.lsp.buf.rename)
vim.keymap.set("n", "<space>lgi", require("fzf-lua").lsp_implementations)
vim.keymap.set("n", "<space>lr",  require("fzf-lua").lsp_references)
vim.keymap.set("n", "<space>la",  require("fzf-lua").lsp_code_actions)
vim.keymap.set("n", "<space>ld",  require("fzf-lua").lsp_document_symbols)
vim.keymap.set("n", "<space>lw",  require("fzf-lua").lsp_workspace_symbols)
vim.keymap.set("n", "<space>lgd",
    function ()
        require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end
)

