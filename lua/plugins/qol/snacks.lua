-- QOL collections
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },

        ---@type snacks.dashboard.Config
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = "", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = "", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
                    { icon = "", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = "", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = "󰔛", key = "P", desc = "Lazy Profile", action = ":Lazy profile", enabled = package.loaded.lazy ~= nil },
                    { icon = "", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },

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
                    auto_close = true,
                    hidden = true,
                    diagnostics_open = true,
                    git_status_open = true,
                },
                files = {
                    hidden = true,
                },
                grep = {
                    hidden = true,
                },
            },
            win = {
                input = {
                    keys = {
                        ["<M-s>"] = { "flash", mode = { "n", "i" } },
                        ["s"] = { "flash" },
                    },
                },
            },
            actions = {
                flash = function(picker)
                    require("flash").jump({
                        pattern = "^",
                        label = { after = { 0, 0 } },
                        search = {
                            mode = "search",
                            exclude = {
                                function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
                            },
                        },
                        action = function(match)
                            local idx = picker.list:row2idx(match.pos[1])
                            picker.list:_move(idx, true, true)
                        end,
                    })
                end,
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
        { "<C-e>",      function() Snacks.explorer() end,                     desc = "File Explorer" },

        -- Picker
        { "<leader>fb", function() Snacks.picker.buffers() end,               desc = "Find Buffers" },
        { "<leader>ff", function() Snacks.picker.smart() end,                 desc = "Find Files" },
        { "<leader>fh", function() Snacks.picker.help() end,                  desc = "Find Help" },
        { "<leader>fn", function() Snacks.picker.notifications() end,         desc = "Find Notification" },
        { "<leader>fp", function() Snacks.picker.projects() end,              desc = "Find Project" },
        { "<leader>fr", function() Snacks.picker.recent_files() end,          desc = "Find Recent" },
        { "<leader>fw", function() Snacks.picker.grep() end,                  desc = "Find Content" },

        -- Search
        { "<leader>sa", function() Snacks.picker.autocmds() end,              desc = "Search Autocmds" },
        { "<leader>sc", function() Snacks.picker.commands() end,              desc = "Search Commands" },
        { "<leader>sf", function() Snacks.picker.files() end,                 desc = "Search Files" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,               desc = "Search Keymaps" },
        { "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Search Marks" },
        { "<leader>sM", function() Snacks.picker.man() end,                   desc = "Search Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,                  desc = "Search Plugin Spec" },
        { "<leader>sR", function() Snacks.picker.registers() end,             desc = "Search Registers" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,             desc = "Search selection or word", mode = { "n", "x" } },

        -- Git
        { "<leader>gl", function() Snacks.picker.git_log() end,               desc = "Git Log" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end,          desc = "Git Log File" },

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

        -- Scratch
        { "<leader>bs", function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
        { "<leader>bS", function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
    },
}
