return {
    -- Statusline
    -- TODO: Customize sections
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                extensions = { "fzf", "lazy", "mason", "neo-tree", "trouble" },
            },
        },
    },

    -- Buffers
    {
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
    },

    -- Mini Icons
    {
        "nvim-mini/mini.icons",
        lazy = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        init = function() require("mini.icons").mock_nvim_web_devicons() end,
    },

    -- Noice notification
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            popupmenu = {
                backend = "cmp",
            },
            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
        },
    },

    -- Git integration for buffers
    {
        "lewis6991/gitsigns.nvim",
        event = "BufEdit",
        opts = {},
    },
}
