-- Highlight TODO comments and can search them
return {
    "folke/todo-comments.nvim",
    event = "BufEdit",
    opts = {},
    keys = {
        { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
        { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
}
