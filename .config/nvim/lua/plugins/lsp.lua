return {
    {
        -- LSP configuration settings
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- Activate blink.cmp capabilities for all servers
            local blink_cap = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = blink_cap })

            vim.lsp.config("ltex_plus", {
                settings = {
                    ltex = {
                        language = "en-US",
                        additionalRules = {
                            languageModel = "~/opt/ngram",
                        },
                    },
                },
            })

            vim.lsp.config("vhdl_tool", {
                cmd = { "vhdl-tool", "lsp" },
                filetypes = { "vhdl" },
                root_markers = { "vhdltool-config.yaml", ".git" },
                settings = {},
            })
            vim.lsp.enable("vhdl_tool")
        end,
    },
    {
        -- Automatically enable LSP configs (`vim.lsp.enable(...)`) from the Mason
        -- package manager
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    {
        -- The Mason LSP/DAP plugin manager
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        -- LSP fidget spinner =)
        "j-hui/fidget.nvim",
        opts = {},
    },
    {
        -- LSP diagnostic formatter
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require("tiny-inline-diagnostic").setup({
                options = {
                    multilines = {
                        enabled = true,
                        always_show = true,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false })
        end,
    },
}
