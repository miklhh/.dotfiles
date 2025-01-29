return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
            vim.cmd([[TSUpdate]])
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        "nvim-treesitter/playground"
    }
}
