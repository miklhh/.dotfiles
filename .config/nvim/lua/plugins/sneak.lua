return {
    "justinmk/vim-sneak",
    lazy = false,
    priority = 1000,
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
    config = function ()

        -- Keymappings
        vim.keymap.set("n", "s", "<Plug>Sneak_s")
        vim.keymap.set("n", "<leader>s", "<Plug>Sneak_S")
        vim.keymap.set("x", "s", "<Plug>Sneak_s")
        vim.keymap.set("x", "<leader>S", "<Plug>Sneak_S")
        vim.keymap.set("o", "s", "<Plug>Sneak_s")
        vim.keymap.set("o", "<leader>S", "<Plug>Sneak_S")

    end,
}
