-- Which key
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    ---@type wk.Opts
    opts = {
        preset = "helix",
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
    },
}
