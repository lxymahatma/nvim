-- QOL collections
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },

        ---@type snacks.lazygit.Config
        lazygit = { enabled = true, configure = false },

        ---@type snacks.notifier.Config
        notifier = {
            enabled = true,
            timeout = 3000,
            top_down = true,
        },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        ---@type snacks.statuscolumn.Config
        statuscolumn = {
            enabled = true,
            folds = {
                open = true,
                git_hl = true,
            },
        },
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
        {
            "<leader>lg",
            function() Snacks.lazygit() end,
            desc = "Open Lazygit",
        },
    },
}
