return {
    -- Search and Navigation
    {
        "folke/flash.nvim",
        opts = {},
        keys = {
            {
                "gs",
                mode = { "n", "x", "o" },
                function() require("flash").jump() end,
                desc = "Flash",
            },
            {
                "gS",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
            },
            {
                "<Leader>r",
                mode = "o",
                function() require("flash").remote() end,
                desc = "Remote Flash",
            },
            {
                "<Leader>R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search",
            },
            {
                "<C-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc = "Toggle Flash Search",
            },
        },
    },

    -- QOL collections
    {
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
    },

    -- Highlight TODO comments and can search them
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>st",
                function() require("todo-comments.fzf").todo() end,
                desc = "Todo",
            },
            {
                "<leader>sT",
                function() require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end,
                desc = "Todo/Fix/Fixme",
            },
        },
    },

    -- FZF
    -- TODO: Customize opts
    {
        "ibhagwan/fzf-lua",
        opts = {},
    },

    -- Diagnostics list
    -- TODO: Customize Keymaps
    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                lsp = {
                    win = { position = "right" },
                },
            },
        },
        cmd = "Trouble",
        keys = {
            {
                "<Leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<Leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<Leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<Leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<Leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<Leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- Find And Replace
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        opts = {
            headerMaxWidth = 80,
        },
    },

    -- Task Runner
    {
        "stevearc/overseer.nvim",
        event = "VeryLazy",
        opts = {
            templates = {
                "builtin",
                "user",
            },
        },
    },
    -- Session manager
    -- TODO: Customize opts
    {
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
    },

    -- Git integration
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
}
