-- Treesitter textobjects
---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufEdit",
    main = "nvim-treesitter.configs",
    opts = {},
}
