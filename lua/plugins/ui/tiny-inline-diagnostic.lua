return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "BufEdit",
    opts = {
        preset = "classic",
        transparent_bg = false,
        transparent_cursorline = true,
        disabled_ft = { "lazy" },
        options = {
            throttle = 20,
            show_source = {
                enabled = true,
            },
            multilines = {
                enabled = true,
                always_show = true,
            },
            show_related = {
                enabled = true,
                max_count = 3,
            },
        },
    },
}
