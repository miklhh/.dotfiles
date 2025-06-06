return {
    {
        -- Fast and capable auto-completion tool for LSPs
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
                preset = 'super-tab',
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
            },
            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    }
                }
            },

            -- Completion menu
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon", "label", "label_description", gap = 1 },
                            { "kind" }
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                }
            },

            fuzzy = { implementation = "rust" },
            signature = { enabled = true },
        },
    },
    {
        -- Default LSP configuration for most LSPs
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp", },
        config = function ()
            local configs = require("lspconfig.configs")
            local util = require("lspconfig.util")

            --
            -- Configuration for custom LSP servers go here
            --
            if configs["vhdl_tool"] == nil then
                configs["vhdl_tool"] = {
                    default_config = {
                        cmd = { 'vhdl-tool', 'lsp' },
                        filetypes = { 'vhdl' },
                        root_dir = util.root_pattern('vhdltool-config.yaml', '.git'),
                        settings = {},
                    }
                }
                require("lspconfig").vhdl_tool.setup{
                    capabilities = require("blink.cmp").get_lsp_capabilities()
                }
            end
        end
    },
    {
        -- The Mason LSP/DAP plugin manager
        "mason-org/mason.nvim",
        opts = {
            -- Mason package manager settings go here
        }
    },
    {
        -- Link between Mason and nvim-lspconfig
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "clangd",
            },
            handlers = {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name)
                    local capabilities = require('blink.cmp').get_lsp_capabilities()
                    require("lspconfig")[server_name].setup{
                        capabilities = capabilities
                    }
                end,

                -- Next, you can provide targeted overrides for specific servers.
                ["ltex"] = function ()
                    local capabilities = require('blink.cmp').get_lsp_capabilities()
                    require("lspconfig")["ltex"].setup {
                        capabilities = capabilities,
                        settings = {
                            ltex = {
                                language = "en-US",
                                additionalRules = {
                                    languageModel = "~/opt/ngram"
                                }
                            }
                        }
                    }
                end,
            }
        },
    },
    {
        -- LSP fidget spinner =)
        "j-hui/fidget.nvim",
        opts = {},
    },
    {
        -- LSP diagnostic formater
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup({
                options = {
                    multilines = {
                        enabled = true,
                        always_show = true,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false })
        end
    },
}
