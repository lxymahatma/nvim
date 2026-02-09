--- @type LazyPluginSpec
return {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {},
    keys = {
        { "<leader>cd", "<cmd>CodeDiff<cr>", desc = "Code Diff" },
    },
}
