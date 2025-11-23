--- Show Trailing Whitespace
return {
    "nvim-mini/mini.trailspace",
    event = "BufEdit",
    opts = {
        only_in_normal_buffers = true,
    },
}
