--
-- Fzf-Lua configuration
-- https://github.com/ibhagwan/fzf-lua
--
require("fzf-lua").setup({
  fzf_opts = {
    ['--layout'] = 'default',
  },
  files = {
    fd_opts = "--color=never --type f --hidden --no-ignore-vcs --follow",
  },
  winopts = {
      height = 0.80,
      width = 0.85,
      preview = {
        layout = 'horizontal',
        vertical = 'up:60%',
        horizontal = 'right:50%',
        hidden = '',
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
    "n", "<leader>.f",
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

