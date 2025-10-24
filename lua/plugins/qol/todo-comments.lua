-- Highlight TODO comments and can search them
return {
    "folke/todo-comments.nvim",
    event = "BufEdit",
    opts = {},
    keys = {
        { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo" },
        { "<leader>fT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
}
