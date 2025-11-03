-- QOL collections
local function term_nav(direction)
    return vim.schedule_wrap(function() vim.cmd.wincmd(direction) end)
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = "󰔛 ", key = "P", desc = "Lazy Profile", action = ":Lazy profile", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true, configure = false },
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
                        ["<M-t>"] = { "trouble_open", mode = { "n", "i" } },
                        ["M-a"] = { "sidekick_send", mode = { "n", "i" } },
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
                ---@diagnostic disable-next-line:need-check-nil
                trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
                sidekick_send = function(...) return require("sidekick.cli.picker.snacks").send(...) end,
            },
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = {
            enabled = true,
            folds = {
                open = true,
                git_hl = true,
            },
        },
        terminal = {
            win = {
                keys = {
                    nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                    nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                    nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                    nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
                },
            },
        },
        words = { enabled = true },
    },
    keys = {
        -- Terminal
        {
            "<C-/>",
            function() Snacks.terminal() end,
            desc = "Toggle Terminal",
            mode = { "n", "t" },
        },

        -- Notifications
        { "<leader>n",  function() Snacks.notifier.show_history() end,     desc = "Notification History" },

        -- Lazygit
        { "<leader>lg", function() Snacks.lazygit() end,                   desc = "Open Lazygit" },

        -- Explorer
        { "<C-e>",      function() Snacks.explorer() end,                  desc = "File Explorer" },

        -- Find
        { "<leader>fb", function() Snacks.picker.buffers() end,            desc = "Buffers" },
        { "<leader>ff", function() Snacks.picker.smart() end,              desc = "Files" },
        { "<leader>fh", function() Snacks.picker.help() end,               desc = "Help" },
        { "<leader>fl", function() Snacks.picker.lines() end,              desc = "Buffer Lines" },
        { "<leader>fn", function() Snacks.picker.notifications() end,      desc = "Notification" },
        { "<leader>fp", function() Snacks.picker.projects() end,           desc = "Project" },
        { "<leader>fr", function() Snacks.picker.recent() end,             desc = "Recent" },
        { "<leader>fw", function() Snacks.picker.grep() end,               desc = "Grep" },

        -- Search
        { "<leader>sa", function() Snacks.picker.autocmds() end,           desc = "Autocmds" },
        { "<leader>sb", function() Snacks.picker.grep_buffers() end,       desc = "Grep Open Buffers" },
        { "<leader>sc", function() Snacks.picker.commands() end,           desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics (Buffer)" },
        { "<leader>sD", function() Snacks.picker.diagnostics() end,        desc = "Diagnostics (Workspace)" },
        { "<leader>sf", function() Snacks.picker.files() end,              desc = "Files" },
        { "<leader>sh", function() Snacks.picker.search_history() end,     desc = "Search History" },
        { "<leader>sH", function() Snacks.picker.highlights() end,         desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end,              desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,              desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,            desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end,            desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end,              desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end,                desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,               desc = "Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end,             desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.registers() end,          desc = "Registers" },
        {
            "<leader>sw",
            function() Snacks.picker.grep_word() end,
            desc = "Selection or Word",
            mode = { "n", "x" },
        },
        { "<leader>sz", function() Snacks.picker.zoxide() end,                                        desc = "Zoxide" },

        -- Git
        { "<leader>gl", function() Snacks.picker.git_log() end,                                       desc = "Git Log" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end,                                  desc = "Git Log File" },

        -- GH
        { "<leader>gi", function() Snacks.picker.gh_issue() end,                                      desc = "GitHub Issues (open)" },
        { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end,                     desc = "GitHub Issues (all)" },
        { "<leader>gp", function() Snacks.picker.gh_pr() end,                                         desc = "GitHub Pull Requests (open)" },
        { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,                        desc = "GitHub Pull Requests (all)" },

        -- Scratch
        { "<leader>bs", function() Snacks.scratch() end,                                              desc = "Toggle Scratch Buffer" },
        { "<leader>bS", function() Snacks.scratch.select() end,                                       desc = "Select Scratch Buffer" },

        -- Todo Comments
        ---@diagnostic disable:undefined-field
        { "<leader>st", function() Snacks.picker.todo_comments() end,                                 desc = "Todo" },
        { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } }) end, desc = "Todo/Fix" },
    },
}
