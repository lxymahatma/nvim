-- Statusline
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
                    cond = require("utils.window").has_multiple_edit_windows,
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
                    cond = require("utils.window").has_multiple_edit_windows,
                },
            },

            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { "lazy", "man", "mason", "overseer", "trouble" },
    },
}
