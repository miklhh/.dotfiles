return {
    {
        -- ``All the Lua function I don't want to write twice''
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        -- Setup/configuraiton of FZF-Lua in: `~/.config/nvim/lua/config/fzf-lua.lua`
    },
    {
        -- Git integration
        "tpope/vim-fugitive",
        lazy = true,
        cmd = { "Git" },
    },
    {
        -- Wipeout like ``well behaved citizens'' (':Bwipeout', ':Bdelete')
        "moll/vim-bbye",
        lazy = false,
        config = function () vim.cmd([[cnoreabbrev bd Bwipeout]]) end,
    },
    {
        -- ``What did that key do again?''
        "folke/which-key.nvim",
        lazy = false,
        opts = {},
    },
    {
        -- Fast on-screen navigation
        "ggandor/leap.nvim",
        lazy = false,
        init = function ()
            local labels_best = 'jklfdsöaiowe,.'
            local labels_backup = 'urm-cx<pq'
            require('leap').opts.safe_labels = labels_best
            require('leap').opts.labels = labels_best .. labels_backup
            vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
            vim.keymap.set({'n', 'x', 'o'}, '<leader>s', '<Plug>(leap-backward)')
            vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
        end,
    },
    {
        -- Proper navigation between Vim splits and Tmux panes
        "christoomey/vim-tmux-navigator",
        lazy = true,
        init = function ()
            vim.g.tmux_navigator_no_mappings = 1
        end,
        keys = {
            { "<M-j>", "<CMD>TmuxNavigateLeft<CR>", mode = { "n" }},
            { "<M-l>", "<CMD>TmuxNavigateUp<CR>", mode = { "n" }},
            { "<M-k>", "<CMD>TmuxNavigateDown<CR>", mode = { "n" }},
            { "<M-ö>", "<CMD>TmuxNavigateRight<CR>", mode = { "n" }},
        },
    },
    {
        -- Align everything
        "junegunn/vim-easy-align",
        lazy = true,
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "EasyAlign" },
        },
    },
    {
        -- Easy undo history access
        "mbbill/undotree",
        lazy = true,
        cmd = {
            "UndotreeToggle",
            "UndotreeShow",
            "UndotreeHide",
            "UndotreeFocus",
            "UndotreePersistUndo",
        },
        keys = {
            {
                "<leader>u",
                "<CMD>UndotreeToggle<CR>",
                mode = { "n" },
                desc = "UndoTree"
            }
        },
    },
    {
        -- Vim-split maximizer
        "szw/vim-maximizer",
        lazy = true,
        cmd = { "MaximizerToggle" },
        keys = {
            {
                "<M-F>",
                "<CMD>MaximizerToggle<CR>",
                mode = { "n" },
                desc = "Toggle Vim Maximizer"
            }
        },
    },
    {
        -- NeoVim sudo read/write (:SudaRead, :SudaWrite)
        "lambdalisue/suda.vim",
        lazy = true,
        cmd = {
            "SudaWrite",
            "SudaRead",
        }
    },
    {
        -- Quickly change surroundings
        "tpope/vim-surround",
        lazy = false,
    },
    {
        -- Yank ring (Emacs `kill ring`-like copying/pasting
        "gbprod/yanky.nvim",
        lazy = false,
        opts = {
            highlight = { on_put = true },
            system_clipboard = {
                -- ISSUE: https://github.com/gbprod/yanky.nvim/issues/123
                sync_with_ring = false,
            },
        }
    },
    {
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
    {
        "stevearc/profile.nvim"
    }
}
