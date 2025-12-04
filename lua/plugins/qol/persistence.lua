-- Session Management
---@type LazyPluginSpec
return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
        need = 1,
        branch = true,
    },
    keys = {
        { "<leader>wr", function() require("persistence").select() end, desc = "Session search" },
    },
}
