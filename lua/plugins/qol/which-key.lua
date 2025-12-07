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
            { "<leader>a", group = "AI" },
            { "<leader>b", group = "Buffer" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Hunk" },
            { "<leader>l", group = "Lazy" },
            { "<leader>o", group = "Overseer" },
            { "<leader>s", group = "Search" },
            { "<leader>u", group = "Toggle" },
            { "<leader>w", group = "Window" },
            { "<leader>x", group = "Trouble" },
        },
        icons = { mappings = false },
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
    },
}
