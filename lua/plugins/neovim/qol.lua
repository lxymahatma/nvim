return {
    -- QOL collections
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            {
                "<leader>n",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "Notification History",
            },
            {
                "<C-/>",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
        },
    },

    -- Highlight TODO comments and can search them
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {},
        keys = {
            {
                "<leader>st",
                function()
                    require("todo-comments.fzf").todo()
                end,
                desc = "Todo",
            },
            {
                "<leader>sT",
                function()
                    require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
                end,
                desc = "Todo/Fix/Fixme",
            },
        },
    },

    -- FZF
    -- TODO: Customize opts
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "echasnovski/mini.icons",
        },
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
                function()
                    require("resession").save()
                end,
                desc = "Save Session",
            },
            {
                "<Leader>sl",
                function()
                    require("resession").load()
                end,
                desc = "Load Session",
            },
            {
                "<Leader>sd",
                function()
                    require("resession").delete()
                end,
                desc = "Delete Session",
            },
        },
    },

    -- Go forward/backward with square brackets
    {
        "echasnovski/mini.bracketed",
        event = "VeryLazy",
        opts = {
            buffer = { suffix = "b", options = {} },
            comment = { suffix = "c", options = {} },
            conflict = { suffix = "x", options = {} },
            diagnostic = { suffix = "d", options = {} },
            file = { suffix = "f", options = {} },
            indent = { suffix = "i", options = {} },
            jump = { suffix = "j", options = {} },
            location = { suffix = "l", options = {} },
            oldfile = { suffix = "o", options = {} },
            quickfix = { suffix = "q", options = {} },
            treesitter = { suffix = "t", options = {} },
            undo = { suffix = "u", options = {} },
            window = { suffix = "w", options = {} },
            yank = { suffix = "y", options = {} },
        },
    },

    -- Show code context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            enable = true,
            multiwindow = false,      -- Enable multiwindow support.
            max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded.
            mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20,     -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
    },

    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {

        },
    },

    -- TODO: Implement Git Stuff
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
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    }
}
