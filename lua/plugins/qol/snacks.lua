-- QOL collections
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
            top_down = true,
        },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        {
            "<leader>n",
            function() Snacks.notifier.show_history() end,
            desc = "Notification History",
        },
        {
            "<C-/>",
            function() Snacks.terminal() end,
            desc = "Toggle Terminal",
        },
    },
}
