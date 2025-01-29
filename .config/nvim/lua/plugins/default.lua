return {
    {
        -- ``All the Lua function I don't want to write twice''
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        -- Git integration in Vim with vim-fugitive
        "tpope/vim-fugitive",
        lazy = false,
    },
    {
        -- Wipeout like ``well behaved citizens'' (':Bwipeout', ':Bdelete')
        "moll/vim-bbye",
        config = function ()
            vim.cmd([[cnoreabbrev bd Bwipeout]])
        end,
    },
    {
        -- Which key does what?
        "folke/which-key.nvim",
        opts = {},
    },
    {
        -- Fast navigation on screen
        "justinmk/vim-sneak",
        lazy = true,
        init = function()
            -- Use Sneak labeling mode, i.e., label sneak matches
            vim.g["sneak#label"] = 1

            -- Case in-sensitive sneaking
            vim.g["sneak#use_ic_scs"] = 1

            -- The set of keys available as labels when sneaking around. Ultimatly, these
            -- labels should:
            -- 1. Be fast (think home row) and easy to use for the keyboard and keyboard
            --    layout at hand.
            -- 2. Not interfear with actians that are common to use *after* a sneak action
            --    has been performed. This since labeling mode fall-through can save one
            --    extra keystroke
            vim.g["sneak#target_labels"] = "fsmörnuw"
        end,
        keys = {
            { "s", "<Plug>Sneak_s", mode = { "n", "x", "o" } },
            { "<leader>s", "<Plug>Sneak_S", mode = { "n", "x", "o" } },
        },
    },
    {
        -- Proper navigation between vim and tmux
        "christoomey/vim-tmux-navigator",
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
        -- UndoTree for easy undo history access
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", mode = { "n" }, desc = "UndoTree" }
        },
    },
    {
        -- Vim Maximizer
        "szw/vim-maximizer",
        keys = {
            { "<M-F>", "<CMD>MaximizerToggle<CR>", mode = { "n" }, desc = "Toggle Vim Maximizer" }
        },
    },
}
