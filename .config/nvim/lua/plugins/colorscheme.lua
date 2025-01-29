return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {},
        config = function()
          vim.cmd([[colorscheme tokyonight-night]])
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        --config = function()
        --  vim.cmd([[colorscheme gruvbox]])
        --end,
    },

}
