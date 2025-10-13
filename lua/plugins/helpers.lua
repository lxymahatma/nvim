return {
    -- Remove bad habit
    {
        "m4xshen/hardtime.nvim",
        enabled = false,
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = {}
    },

    -- Which key
    -- TODO: Customize opts
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },

    -- Precognition shows keys for movements
    {
        "tris203/precognition.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {},
    },

    -- Vim training
    {
        "ThePrimeagen/vim-be-good",
        lazy = true,
    },
}
