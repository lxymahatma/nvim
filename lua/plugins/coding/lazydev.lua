-- Workspace LuaLS setup
return {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
        library = {
            { path = "lazy.nvim" },
            { path = "snacks.nvim", words = { "Snacks" } },
        },
    },
}
