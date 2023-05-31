local cmp = require'cmp'
local lspkind = require('lspkind')

-- Completion engine setup.
cmp.setup({
    preselect = "None",
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            --require('lauasnip').lsp_expand(args.body) -- For `luasnip` users.
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
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },                  -- NVim LSP autocompletions
        { name = 'luasnip' },                   -- For Luasnip users
        { name = 'vsnip' },                     -- VSnip autocompletions
        { name = 'path' },                      -- cmp-path autocompletions
        --{ name = 'nvim_lsp_signature_help' },   -- LSP signatures
        --{ name = 'buffer' },                    -- cmp-buffer autocompletions
    }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
    {
      { name = 'path' }
    },
    {
      { name = 'cmdline' }
    })
})

-- LSP Document symbols on '/@' cmdline
require'cmp'.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
  {
    { name = 'nvim_lsp_document_symbol' }
  },
  {
    { name = 'buffer' }
  })
})
