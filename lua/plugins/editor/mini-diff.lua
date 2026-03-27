---@type LazyPluginSpec
return {
    "nvim-mini/mini.diff",
    event = "BufEdit",
    opts = {
        view = {
            style = "sign",
            signs = {
                add = "▎",
                change = "▎",
                delete = "",
            },
        },
        mappings = {
            apply = "gh",
            reset = "gH",
            textobject = "gh",
            goto_first = "[H",
            goto_last = "]H",
            goto_prev = "[c",
            goto_next = "]c",
        },
    },
    keys = {
        { "<leader>hd", function() require("mini.diff").toggle_overlay(0) end, desc = "Toggle diff" },
    },
}
