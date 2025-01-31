return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "junegunn/seoul256.vim",
        lazy = false,
        priority = 1000,
    },
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
    },
    {
        "tanvirtin/monokai.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').load()
        end
    },
}
