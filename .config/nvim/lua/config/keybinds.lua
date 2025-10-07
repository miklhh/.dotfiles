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
vim.keymap.set({"n", "x"}, "d", '"_d', { noremap = true })
vim.keymap.set({"n", "x"}, "x", '"_x', { noremap = true })
vim.keymap.set({"n", "x"}, "c", '"_c', { noremap = true })
vim.keymap.set({"n", "x"}, "C", '"_C', { noremap = true })
vim.keymap.set(
    {"n", "x"}, "<leader>d", '""d',
    { noremap = true, desc="Yank + Delete" }
)

-- Jump 20 characters with K and J
vim.keymap.set({"n", "v"}, "K", "20k", { noremap = true })
vim.keymap.set({"n", "v"}, "J", "20j", { noremap = true })

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
vim.keymap.set(
    "n", "<leader>i",
    vim.lsp.buf.hover,
    { desc = "LSP: Hover" }
)
vim.keymap.set(
    "n", "<leader>lR",
    vim.lsp.buf.rename,
    { desc = "LSP: Rename" }
)
vim.keymap.set(
    "n", "<leader>lh",
    vim.lsp.buf.document_highlight,
    { desc = "LSP: Document highlight" }
)
vim.keymap.set(
    "n", "<leader>lH",
    vim.lsp.buf.clear_references,
    { desc = "LSP: Document highlight" }
)
vim.keymap.set(
    "n", "<leader>ltd",
    require("tiny-inline-diagnostic").toggle,
    { desc = "LSP: Toggle inline diagnostics" }
)
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")


----------------------------------------------------------------------------------------
--                                    FZF-Lua                                         --
----------------------------------------------------------------------------------------

local fzf_lua = require('fzf-lua')

vim.keymap.set(
    "n", "<leader>f", require('fzf-lua').builtin,
    { desc = "Fzf-Lua: builtin" }
)
vim.keymap.set(
    "n", "<leader>e", require('fzf-lua').files,
    { desc = "Fzf-Lua: files" }
)
vim.keymap.set(
    "n", "<leader>w", require('fzf-lua').buffers,
    { desc = "Fzf-Lua: buffers" }
)
vim.keymap.set(
    "n", "<leader>g", require('fzf-lua').live_grep,
    { desc = "Fzf-Lua: live grep" }
)
vim.keymap.set(
    "n", "<leader>.e", function () fzf_lua.files({ cwd = '~/.dotfiles/' }) end,
    { desc = "Fzf-Lua: files (`~/.dotfiles/`)" }
)
vim.keymap.set(
    "n", "<leader>,e", function () fzf_lua.files({ cwd = '~' }) end,
    { desc = "Fzf-Lua: files (`~`)" }
)

vim.keymap.set(
    "n", "<leader>lr", fzf_lua.lsp_references,
    { desc = "Fzf-Lua: LSP references" }
)
vim.keymap.set(
    "n", "<leader>la", fzf_lua.lsp_code_actions,
    { desc = "Fzf-Lua: LSP code actions" }
)
vim.keymap.set(
    "n", "<leader>ld", fzf_lua.lsp_document_symbols,
    { desc = "Fzf-Lua: LSP document symbols" }
)
vim.keymap.set(
    "n", "<leader>lw", fzf_lua.lsp_workspace_symbols,
    { desc = "Fzf-Lua: LSP workspace symbols" }
)
vim.keymap.set(
    "n", "<leader>lgd", function () fzf_lua.lsp_definitions({ jump1 = true }) end,
    { desc = "Fzf-Lua: LSP definitions" }
)
vim.keymap.set(
    "n", "<leader>lgi", fzf_lua.lsp_implementations,
    { desc = "Fzf-Lua: LSP implementations" }
)
