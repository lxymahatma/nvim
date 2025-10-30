-- Statusline
-- TODO: Customize sections
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            theme = "auto",
            globalstatus = true,
            disabled_filetypes = { statusline = { "snacks_dashboard" } },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "info", "hint" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                },
            },
            lualine_c = { "filename" },
            lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = { "lazy", "man", "mason", "overseer", "trouble" },
    },
}
