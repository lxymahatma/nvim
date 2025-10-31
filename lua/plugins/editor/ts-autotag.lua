return {
    "windwp/nvim-ts-autotag",
    event = "BufEdit",

    ---@type nvim-ts-autotag.Opts
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    },
}
