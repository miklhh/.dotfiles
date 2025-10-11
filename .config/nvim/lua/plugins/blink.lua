return {
    {
        -- Fast and capable auto-completion tool
        "saghen/blink.cmp",
        dependencies = {
            { "onsails/lspkind-nvim" },
            { "folke/lazydev.nvim", ft = "lua", opts = {} },
        },

        -- use a release tag to download pre-built Rust fuzzy find binary
        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to
            -- navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own
            -- keymap.
            keymap = {
                preset = "super-tab",
                ["<C-j>"] = { "select_next" },
                ["<C-k>"] = { "select_prev" },
            },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            },
            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },

            -- Completion menu
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon", "label", "label_description", gap = 1 },
                            { "kind" },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },

            fuzzy = { implementation = "rust" },
            signature = { enabled = true },
        },
    },
}
