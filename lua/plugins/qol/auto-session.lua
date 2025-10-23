return {
    "rmagatti/auto-session",
    lazy = false,

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        auto_restore = false,
        bypass_save_filetypes = { "snacks_dashboard" },

        ---@type SessionLens
        session_lens = {
            picker = "snacks",
            picker_opts = {
                preset = "dropdown",
                preview = false,
                layout = {
                    width = 0.4,
                    height = 0.4,
                },
            },
        },
        pre_restore_cmds = {
            function()
                local picker = Snacks.picker.get({ source = "explorer" })[1]
                if picker then picker:close() end
            end,
        },
    },
    keys = {
        { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<leader>ws", "<cmd>AutoSession save<CR>",   desc = "Save session" },
    },
}
