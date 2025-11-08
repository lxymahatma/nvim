-- Statusline
local function get_copilot_status_component()
    local icons = {
        Error = { " ", "DiagnosticError" },
        Inactive = { " ", "MsgArea" },
        Warning = { " ", "DiagnosticWarn" },
        Normal = { " ", "Special" },
    }

    return {
        function()
            local status = require("sidekick.status").get()
            return status and vim.tbl_get(icons, status.kind, 1)
        end,
        cond = function() return require("sidekick.status").get() ~= nil end,
        color = function()
            local status = require("sidekick.status").get()
            local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(icons, status.kind, 2))
            return { fg = Snacks.util.color(hl) }
        end,
    }
end

local function get_cli_session_component()
    return {
        function()
            local status = require("sidekick.status").cli()
            return " " .. (#status > 1 and #status or "")
        end,
        cond = function() return #require("sidekick.status").cli() > 0 end,
        color = function() return { fg = Snacks.util.color("Special") } end,
    }
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            theme = "auto",
            globalstatus = true,
            disabled_filetypes = {
                statusline = { "snacks_dashboard" },
                winbar = { "snacks_dashboard" },
            },
            refresh = {
                statusline = 500,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                {
                    "diff",
                    colored = true,
                    symbols = {
                        added = "+",
                        modified = "~",
                        removed = "-",
                    },
                },
            },
            lualine_c = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "info", "hint" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                },
                {
                    "filetype",
                    colored = true,
                    icon_only = false,
                    icon = { align = "left" },
                },
            },
            lualine_x = {
                get_copilot_status_component(),
                get_cli_session_component(),
                "overseer",
                {
                    "encoding",
                    show_bomb = true,
                },
                {
                    "fileformat",
                    symbols = {
                        unix = "",
                        dos = "",
                        mac = "",
                    },
                },
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    "filename",
                    cond = require("helpers.window").is_edit_window,
                    file_status = false,
                    path = 3,
                },
            },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        inactive_winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    "filename",
                    cond = require("helpers.window").is_edit_window,
                    file_status = false,
                    path = 3,
                },
            },

            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { "lazy", "man", "mason", "overseer", "trouble" },
    },
}
