--
-- Fzf-Lua configuration
-- https://github.com/ibhagwan/fzf-lua
--
require("fzf-lua").setup({
  winopts = {
      height = 0.60,
      width = 0.85,
      preview = {
        layout = 'horizontal',
        vertical = 'up:60%',
        horizontal = 'right:50%',
        hidden = '',
      },
  }
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
    "n", "<leader>e",
    "<cmd>lua require('fzf-lua').files()<CR>"
)
vim.keymap.set(
    "n", "<leader>w",
    "<cmd>lua require('fzf-lua').buffers()<CR>"
)

