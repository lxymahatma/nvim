--- Show Trailing Whitespace
---@type LazyPluginSpec
return {
    "nvim-mini/mini.trailspace",
    event = "BufEdit",
    opts = {
        only_in_normal_buffers = true,
    },
}
