--- @type LazyPluginSpec
return {
    "HakonHarnes/img-clip.nvim",
    event = "BufEdit",
    opts = {},
    keys = {
        { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image" },
    },
}
