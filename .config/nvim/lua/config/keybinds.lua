---- Map tab to the above tab complete functions
--vim.api.nvim_set_keymap('i', '<C-n>', 'v:lua.tab_complete()', { expr = true })
--vim.api.nvim_set_keymap('s', '<C-n>', 'v:lua.tab_complete()', { expr = true })
--vim.api.nvim_set_keymap('i', '<C-p>', 'v:lua.s_tab_complete()', { expr = true })
--vim.api.nvim_set_keymap('s', '<C-p>', 'v:lua.s_tab_complete()', { expr = true })
--
---- Map compe confirm and complete functions
--vim.api.nvim_set_keymap('i', 'ii', 'v:lua.on_ii()', { expr = true })
--vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
--
--vim.api.nvim_set_keymap('i', '<C-h>', 'v:lua.jump_prev()', { expr = true })
--vim.api.nvim_set_keymap('s', '<C-h>', 'v:lua.jump_prev()', { expr = true })
--vim.api.nvim_set_keymap('i', '<C-l>', 'v:lua.jump_next()', { expr = true })
--vim.api.nvim_set_keymap('s', '<C-l>', 'v:lua.jump_next()', { expr = true })

-- Modes
--   'n' := normal mode
--   'i' := insert mode
--   'v' := visual mode
--   'x' := visual block mode
--   't' := terminal mode
--   'c' := command mode

local function lsp_set_keymap(...)
    vim.api.nvim_set_keymap(...)
end

local lsp_opts =  {
    noremap=true,
    silent=true,
}

-- See `:help vim.lsp.*` for documentation on any of the below functions
lsp_set_keymap('n', '<space>i',   '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)
lsp_set_keymap('n', '<space>lR',  '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)
lsp_set_keymap('n', '<space>lgi', '<cmd>FzfLua lsp_implementations<CR>', lsp_opts)
lsp_set_keymap('n', '<space>lr',  '<cmd>FzfLua lsp_references<CR>', lsp_opts)
lsp_set_keymap('n', '<space>la',  '<cmd>FzfLua lsp_code_actions<CR>', lsp_opts)
lsp_set_keymap('n', '<space>ld',  '<cmd>FzfLua lsp_document_symbols<CR>', lsp_opts)
lsp_set_keymap('n', '<space>lw',  '<cmd>FzfLua lsp_workspace_symbols<CR>', lsp_opts)
lsp_set_keymap(
    'n', '<space>lgd',
    '<cmd>lua require("fzf-lua").lsp_definitions({jump_to_single_result = true})<CR>',
    lsp_opts
)

-- Toggle LSP diagnostics through plugin 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
lsp_set_keymap('n', '<space>lt', '<cmd>ToggleDiag<CR>', lsp_opts)

