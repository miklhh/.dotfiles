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

-- Setup FZF-Lua post configuration
require('config.fzf-lua')

-- Setup keybinds
require('config.keybinds')

----------------------------------------------------------------------------------------
--                               Options and apperance                                --
----------------------------------------------------------------------------------------

-- Global options
vim.opt.autoread = true
vim.opt.colorcolumn = "88"
vim.opt.textwidth = 88
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
vim.opt.wrap = false

-- Profiling support
function START_PROFILE (output_file)
    require("plenary.profile").start(output_file, { flame = true })
end
function STOP_PROFILE ()
    require("plenary.profile").stop()
end

local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end

  local function toggle_profile()
    local prof = require("profile")
    if prof.is_recording() then
      prof.stop()
      vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
        if filename then
          prof.export(filename)
          vim.notify(string.format("Wrote %s", filename))
        end
      end)
    else
      prof.start("*")
    end
  end
  vim.keymap.set("", "<f1>", toggle_profile)
end
