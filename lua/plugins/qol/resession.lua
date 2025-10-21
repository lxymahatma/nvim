-- Session manager
-- TODO: Customize opts
return {
    "stevearc/resession.nvim",
    opts = {
        overseer = {},
    },
    keys = {
        {
            "<Leader>ss",
            function() require("resession").save() end,
            desc = "Save Session",
        },
        {
            "<Leader>sl",
            function() require("resession").load() end,
            desc = "Load Session",
        },
        {
            "<Leader>sd",
            function() require("resession").delete() end,
            desc = "Delete Session",
        },
    },
}
