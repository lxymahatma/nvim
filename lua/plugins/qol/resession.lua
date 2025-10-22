-- Session manager
-- TODO: Customize opts
return {
    "stevearc/resession.nvim",
    opts = {
        overseer = {},
    },
    keys = {
        { "<leader>ss", function() require("resession").save() end,   desc = "Save Session" },
        { "<leader>sl", function() require("resession").load() end,   desc = "Load Session" },
        { "<leader>sd", function() require("resession").delete() end, desc = "Delete Session" },
    },
}
