-- Buffers
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",

    ---@type bufferline.Config
    ---@diagnostic disable:missing-fields
    opts = {
        options = {
            color_icons = true,
            close_command = function(n) Snacks.bufdelete(n) end,
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "snacks_layout_box",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
            themable = true,
        },
        highlights = require("catppuccin.special.bufferline").get_theme(),
    },
    keys = {
        { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",    desc = "Prev Buffer" },
        { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",    desc = "Next Buffer" },
        { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",    desc = "Toggle Pin Buffer" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Current Buffer" },
        { "<leader>br", "<cmd>BufferLineCloseRight<cr>",   desc = "Delete Buffers on the Right" },
        { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>",    desc = "Delete Buffers on the Left" },
    },
}
