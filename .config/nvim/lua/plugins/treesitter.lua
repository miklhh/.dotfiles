---@diagnostic disable: missing-fields

return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early if opening file on cmdline
        init = function(plugin)
            -- Some lazy performance optimization.
            -- See: `http://www.lazyvim.org/plugins/treesitter` for more info
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },
                sync_install = false,
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    "cpp",
                    "dockerfile",
                    "dot",
                    "go",
                    "javascript",
                    "julia",
                    "llvm",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "matlab",
                    "ninja",
                    "passwd",
                    "perl",
                    "python",
                    "query",
                    "regex",
                    "ruby",
                    "rust",
                    "toml",
                    "typescript",
                    "vhdl",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
            })
        end,
    },
}
