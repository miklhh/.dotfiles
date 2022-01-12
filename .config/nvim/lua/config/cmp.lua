local cmp = require'cmp'
local lspkind = require('lspkind')

-- Completion engine setup.
cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        maxwidth = 70,
      }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- NVim LSP autocompletions
        { name = 'vsnip' },     -- VSnip autocompletions
        { name = 'path' },      -- cmp-path autocompletions
        { name = 'buffer' },    -- cmp-buffer autocompletions
    }),
    documentation = {
        --border = { 'a', '-', 'c', '|' }
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
