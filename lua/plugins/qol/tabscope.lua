return {
    "lxymahatma/tabscope.nvim",
    event = "VeryLazy",

    ---@type Tabscope.Config
    opts = {
        branch = true,
        integrations = {
            persistence = true,
        },
    },
}
