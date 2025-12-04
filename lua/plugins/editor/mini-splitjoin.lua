-- Split and join arguments
---@type LazyPluginSpec
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
