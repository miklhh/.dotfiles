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
    "n", "<leader>lr",
    require("fzf-lua").lsp_references,
    { desc = "LSP: References" }
)
vim.keymap.set(
    "n", "<leader>la",
    require("fzf-lua").lsp_code_actions,
    { desc = "LSP: Code actions" }
)
vim.keymap.set(
    "n", "<leader>ld",
    require("fzf-lua").lsp_document_symbols,
    { desc = "LSP: Document symbols" }
)
vim.keymap.set(
    "n", "<leader>lw",
    require("fzf-lua").lsp_workspace_symbols,
    { desc = "LSP: Workspace symbols" }
)
vim.keymap.set(
    "n", "<leader>lgd",
    function ()
        require("fzf-lua").lsp_definitions({ jump1 = true })
    end,
    { desc = "LSP: Go to definition" }
)
vim.keymap.set(
    "n", "<leader>lgi",
    require("fzf-lua").lsp_implementations,
    { desc = "LSP: Go to implementation" }
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

vim.keymap.set("n", "<leader>f", require('fzf-lua').builtin)
vim.keymap.set("n", "<leader>e", require('fzf-lua').files)
vim.keymap.set(
    "n", "<leader>.e",
    function ()
        require('fzf-lua').files({ cwd = '~/.dotfiles/' })
    end
)
vim.keymap.set(
    "n", "<leader>,e",
    function ()
        require('fzf-lua').files({ cwd = '~' })
    end
)
vim.keymap.set(
    "n", "<leader>w",
    function ()
        require('fzf-lua').buffers()
    end
)
