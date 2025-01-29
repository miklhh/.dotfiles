return {
    {
        -- ``All the Lua function I don't want to write twice''
        "nvim-lua/plenary.nvim"
    },
    {
        -- Git integration in Vim with vim-fugitive
        "tpope/vim-fugitive"
    },
    {
        -- Wipeout like ``well behaved citizens'' (':Bwipeout', ':Bdelete')
        "moll/vim-bbye",
        lazy = false,
        config = function ()
            vim.cmd([[cnoreabbrev bd Bwipeout]])
        end
    },
    {
        "folke/which-key.nvim",
        opts = {

        },
    }
}
