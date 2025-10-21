-- Which key
-- TODO: Customize opts
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,

    ---@module "which-key"
    ---@type wk.Opts
    opts = {
        preset = "helix",
    },
    keys = {
        {
            "<leader>?",
            function() require("which-key").show({ global = false }) end,
            desc = "Buffer Local Keymaps",
        },
    },
}
