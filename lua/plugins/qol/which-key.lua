-- Which key
---@type LazyPluginSpec
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    ---@type wk.Opts
    opts = {
        preset = "helix",
        ---@type wk.Spec
        spec = {
            { "<leader>a", group = "AI", icon = { icon = " ", color = "green" } },
            { "<leader>b", group = "Buffer", icon = { icon = "󰈔", color = "cyan" } },
            { "<leader>c", group = "Code", icon = { icon = " ", color = "orange" } },
            { "<leader>d", group = "Debug", icon = { icon = " ", color = "red" } },
            { "<leader>f", group = "Find", icon = { icon = " ", color = "green" } },
            { "<leader>g", group = "Git", icon = { icon = "󰊢 ", color = "orange" } },
            { "<leader>h", group = "Hunk", icon = { icon = " ", color = "purple" } },
            { "<leader>l", group = "Lazy", icon = { icon = "󰒲 ", color = "blue" } },
            { "<leader>o", group = "Overseer", icon = { icon = " ", color = "cyan" } },
            { "<leader>s", group = "Search", icon = { icon = " ", color = "yellow" } },
            { "<leader>u", group = "Toggle", icon = { icon = " ", color = "yellow" } },
            { "<leader>w", group = "Window", icon = { icon = " ", color = "blue" } },
            { "<leader>x", group = "Trouble", icon = { icon = " ", color = "red" } },
        },
        icons = {
            rules = {
                { pattern = "search", icon = " ", color = "yellow" },
            },
        },
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
    },
}
