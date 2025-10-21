-- Split and join arguments
return {
    "nvim-mini/mini.splitjoin",
    event = "BufEdit",
    opts = {
        mappings = {
            toggle = "gz",
            split = "",
            join = "",
        },
    },
}
