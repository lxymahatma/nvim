-- Auto pairs
return {
    "nvim-mini/mini.pairs",
    event = "BufEdit",
    opts = {
        modes = { insert = true, command = true, terminal = false },
    },
}
