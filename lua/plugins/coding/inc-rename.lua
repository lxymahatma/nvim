-- Rename
return {
    "smjonas/inc-rename.nvim",
    opts = {
        input_buffer_type = "snacks",
    },
    keys = {
        {
            "<leader>rn",
            mode = "n",
            function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            expr = true,
            desc = "Inc Rename",
        },
    },
}
