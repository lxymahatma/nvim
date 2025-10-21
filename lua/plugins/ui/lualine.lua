-- Statusline
-- TODO: Customize sections
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            theme = "auto",
            globalstatus = true,
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = { "fzf", "lazy", "mason", "neo-tree", "trouble" },
        },
    },
}
