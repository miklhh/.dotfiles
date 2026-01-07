---@diagnostic disable: missing-fields

return {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate"
    }
}
