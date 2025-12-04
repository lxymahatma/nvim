-- Git integration for buffers
---@type LazyPluginSpec
return {
    "lewis6991/gitsigns.nvim",
    event = "BufEdit",

    ---@type Gitsigns.Config
    opts = {},
}
