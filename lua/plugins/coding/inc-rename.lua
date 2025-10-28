-- Rename
return {
    "smjonas/inc-rename.nvim",

    ---@type inc_rename.UserConfig
    opts = {
        input_buffer_type = "snacks",
    },
    keys = {
        {
            "<leader>rn",
            function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            expr = true,
            desc = "Inc Rename",
            mode = "n",
        },
    },
}
