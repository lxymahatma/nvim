-- Buffers
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            close_command = function(n) Snacks.bufdelete(n) end,
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
                },
                {
                    filetype = "snacks_layout_box",
                },
            },
            color_icons = true,
        },
        highlights = require("catppuccin.special.bufferline").get_theme(),
    },
    keys = {
        { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "<S-l>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<Leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin Buffer" },
        {
            "<Leader>bd",
            function() Snacks.bufdelete() end,
            desc = "Delete Current Buffer",
        },
        { "<Leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers on the Right" },
        { "<Leader>bl", "<cmd>BufferLineCloseLeft<cr>",  desc = "Delete Buffers on the Left" },
    },
}
