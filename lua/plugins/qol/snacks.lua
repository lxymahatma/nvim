-- QOL collections
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,

        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },

            ---@type snacks.explorer.Config
            explorer = {
                enabled = true,
                replace_netrw = true,
            },
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
            picker = {
                enabled = true,
                matcher = {
                    frecency = true,
                },
                sources = {
                    explorer = {
                        hidden = true,
                        diagnostics_open = true,
                        git_status_open = true,
                    },
                    grep = {
                        hidden = true,
                    },
                },
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
            -- Terminal
            { "<C-/>",      function() Snacks.terminal() end,                     desc = "Toggle Terminal" },

            -- Notifications
            { "<leader>n",  function() Snacks.notifier.show_history() end,        desc = "Notification History" },

            -- Lazygit
            { "<leader>lg", function() Snacks.lazygit() end,                      desc = "Open Lazygit" },

            -- Explorer
            { "<leader>fe", function() Snacks.explorer() end,                     desc = "File Explorer" },

            -- Picker
            { "<leader>fs", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
            { "<leader>fb", function() Snacks.picker.buffers() end,               desc = "Find Buffers" },
            { "<leader>ff", function() Snacks.picker.files() end,                 desc = "Find Files" },
            { "<leader>fh", function() Snacks.picker.help() end,                  desc = "Find Help" },
            { "<leader>fn", function() Snacks.picker.notifications() end,         desc = "Find Notification" },
            { "<leader>fp", function() Snacks.picker.projects() end,              desc = "Find Project" },
            { "<leader>fr", function() Snacks.picker.recent() end,                desc = "Find Recent" },
            { "<leader>fw", function() Snacks.picker.grep() end,                  desc = "Find Content" },

            { "<leader>sk", function() Snacks.picker.keymaps() end,               desc = "Search Keymaps" },
            { "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Search Marks" },
            { "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Search Plugin Spec" },
            { "<leader>sw", function() Snacks.picker.grep_word() end,             desc = "Search selection or word", mode = { "n", "x" } },

            -- LSP
            { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
            { "gr",         function() Snacks.picker.lsp_references() end,        desc = "References",               nowait = true },
            { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto Type Definition" },
            { "gai",        function() Snacks.picker.lsp_incoming_calls() end,    desc = "Calls Incoming" },
            { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,    desc = "Calls Outgoing" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        },
    },
}
