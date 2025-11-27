return {
    "lxymahatma/tabscope.nvim",
    lazy = true,

    ---@type Tabscope.Config
    opts = {
        branch = true,
        integrations = {
            persistence = true,
        },
    },
}
