--
-- Keybinds for using the LSP
--


local fzf_lua = require("fzf-lua")

-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>i',   vim.lsp.buf.hover)
vim.keymap.set('n', '<space>lR',  vim.lsp.buf.rename)
vim.keymap.set('n', '<space>lgi', fzf_lua.lsp_implementations)
vim.keymap.set('n', '<space>lr',  fzf_lua.lsp_references)
vim.keymap.set('n', '<space>la',  fzf_lua.lsp_code_actions)
vim.keymap.set('n', '<space>ld',  fzf_lua.lsp_document_symbols)
vim.keymap.set('n', '<space>lw',  fzf_lua.lsp_workspace_symbols)
vim.keymap.set(
    'n', '<space>lgd',
    function ()
        fzf_lua.lsp_definitions({jump_to_single_result = true})
    end
)
