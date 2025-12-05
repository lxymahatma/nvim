-- Task Runner
---@type LazyPluginSpec
return {
    "stevearc/overseer.nvim",
    cmd = {
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerSaveBundle",
        "OverseerLoadBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerRun",
        "OverseerInfo",
        "OverseerBuild",
        "OverseerQuickAction",
        "OverseerTaskAction",
        "OverseerClearCache",
    },

    ---@type overseer.SetupOpts
    opts = {},
    keys = {
        { "<leader>ow", "<cmd>OverseerToggle<cr>",     desc = "Task list" },
        { "<leader>or", "<cmd>OverseerRun<cr>",        desc = "Run task" },
        { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
    },
}
