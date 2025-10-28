-- Task Runner
return {
    "stevearc/overseer.nvim",
    event = "VeryLazy",

    ---@type overseer.Config
    opts = {
        templates = {
            "builtin",
            "user",
        },
    },
}
