return {
    {
        -- Fast on-screen navigation
        url = "https://codeberg.org/andyg/leap.nvim",
        lazy = false,
        init = function()
            local labels_best = "jklfdsaiowe,."
            local labels_backup = "urm-cx<pq"
            require("leap").opts.safe_labels = ""
            require("leap").opts.labels = labels_best .. labels_backup
            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
            vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-backward)")
            vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
        end,
    },
}
