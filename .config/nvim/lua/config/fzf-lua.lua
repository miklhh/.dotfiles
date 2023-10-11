--
-- Fzf-Lua configuration
-- Plugin: https://github.com/ibhagwan/fzf-lua
--

local actions = require("fzf-lua").actions

require("fzf-lua").setup({

  fzf_opts = {
    ['--layout'] = 'default',
  },
  files = {
    fd_opts = 
        "--color=never "    ..
        "--type f "         ..
        "--hidden "         ..
        "--no-ignore-vcs "  ..
        "--follow "         ..
        "",
  },
  grep = {
    rg_opts = 
        "--hidden "         ..
        "--color=always "   ..
        "--smart-case "     ..
        "--no-ignore-vcs "  ..
        "",
  },
  winopts = {
    height          = 0.80,
    width           = 0.85,
    preview = {
      layout        = 'horizontal',
      vertical      = 'up:60%',
      horizontal    = 'right:50%',
      hidden = '',
    },
  },
  actions = {
    files = {
      -- instead of the default action 'actions.file_edit_or_qf' it's important to
      -- define all other actions here as this table does not get merged with the
      -- global defaults
      ["default"]   = actions.file_edit,
      ["ctrl-s"]    = actions.file_split,
      ["ctrl-v"]    = actions.file_vsplit,
      ["ctrl-t"]    = actions.file_tabedit,
      ["alt-q"]     = actions.file_sel_to_qf,
    },
  },

})


--
-- Keybindings
--
vim.keymap.set(
    "n", "<leader>f",
    "<cmd>lua require('fzf-lua').builtin()<CR>"
)
vim.keymap.set(
    "n", "<leader>.e",
    "<cmd>lua require('fzf-lua').files({ cwd = '~/.dotfiles/' })<CR>"
)
vim.keymap.set(
    "n", "<leader>,e",
    "<cmd>lua require('fzf-lua').files({ cwd = '~' })<CR>"
)
vim.keymap.set(
    "n", "<leader>e",
    "<cmd>lua require('fzf-lua').files()<CR>"
)
vim.keymap.set(
    "n", "<leader>w",
    "<cmd>lua require('fzf-lua').buffers()<CR>"
)

