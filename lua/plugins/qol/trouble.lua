-- Diagnostics list
---@type LazyPluginSpec
return {
    "folke/trouble.nvim",

    ---@type trouble.Config
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace Diagnostics" },
    },
}
