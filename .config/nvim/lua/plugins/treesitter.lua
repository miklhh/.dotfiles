---@diagnostic disable: missing-fields

return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early if opening file on cmdline
        init = function (plugin)
            -- Some lazy performance optimization.
            -- See: `http://www.lazyvim.org/plugins/treesitter` for more info
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        config = function ()
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
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early if opening file on cmdline
        opts = {
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',

            -- Separator between context and content. Should be a single character
            -- string, like '-'. When separator is set, the context will only show up
            -- when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20,
        }
    },
}
