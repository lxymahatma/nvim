-- Task Runner
return {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    opts = {
        templates = {
            "builtin",
            "user",
        },
    },
}
