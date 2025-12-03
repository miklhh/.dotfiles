--
-- Brand new NeoVim configuration
-- Author: Mikael Henriksson (2025)
--

-- Enable Lua byte-compilation caching
if vim.loader then
    vim.loader.enable()
end

-- Disable built-in Netrw plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Map leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Search settings
-- stylua: ignore start
vim.opt.incsearch = true        -- update search in real-time
vim.opt.ignorecase = true       -- case in-sensitive searches ...
vim.opt.smartcase = true        -- ... unless capital letters are used
-- stylua: ignore end

-- Appearance and behaviour
-- stylua: ignore start
vim.opt.autoread = true         -- auto re-read externally modified files
vim.opt.colorcolumn = "88"      -- this guy right here                              -->
vim.opt.cursorline = true       -- highlight the cursor line
vim.opt.expandtab = true        -- prefer spaces for tabs
vim.opt.laststatus = 2          -- always show status line
vim.opt.lazyredraw = true       -- do not re-draw screen when executing macros
vim.opt.mouse = "a"             -- enable mouse support in all modes
vim.opt.number = true           -- enable line numbers
vim.opt.relativenumber = true   -- enable relative line numbers
vim.opt.ruler = true            -- show ruler (`line,column`) in the status line
vim.opt.scrolloff = 4           -- minimal number of lines displayed above/below cursor
vim.opt.shiftwidth = 4          -- number of columns making up one level of indentaiton
vim.opt.showmode = true         -- show active mode under status line
vim.opt.signcolumn = "yes"      -- sign column (left of the line numbers)
vim.opt.splitbelow = true       -- when splitting horizontally, put new split below
vim.opt.splitright = true       -- when splitting vertically, put new split to the right
vim.opt.tabstop = 4             -- number of columns the tab char (ASCII: 9) indents
vim.opt.termguicolors = true    -- enable 24-bit color in the TUI
vim.opt.textwidth = 88          -- default text width (used for e.g. with `gw`)
vim.opt.winborder = "rounded"   -- rounded border on floating windows
vim.opt.wrap = false            -- do not wrap text around edge of neovim border
-- stylua: ignore end

-- Help in a new buffer `:Help <something>`
vim.api.nvim_create_user_command("Help", function(opts)
    vim.cmd("enew")
    vim.bo.buftype = "help"
    vim.bo.buflisted = false
    vim.cmd("keepalt h " .. opts.args)
end, { nargs = 1, complete = "help" })

-- Lazy plugin manager
require("config.lazy")

-- fzf-lua post configuration
require("config.fzf-lua")

-- Setup keybinds
require("config.keybinds")
