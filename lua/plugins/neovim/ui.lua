return {
    -- File Explorer
    -- TODO: Customize keymaps
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "echasnovski/mini.icons",
            "MunifTanjim/nui.nvim",
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
                require("neo-tree")
            end
        end,
        opts = function(_, opts)
            local function on_move(data)
                Snacks.rename.on_rename_file(data.source, data.destination)
            end
            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED,   handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
            return vim.tbl_deep_extend("force", opts, {
                sources = { "filesystem", "buffers", "git_status" },
                open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
                filesystem = {
                    bind_to_cwd = false,
                    follow_current_file = { enabled = true },
                    use_libuv_file_watcher = true,
                },
                window = {
                    mappings = {
                        ["l"] = "open",
                        ["h"] = "close_node",
                        ["<space>"] = "none",
                        ["Y"] = {
                            function(state)
                                local node = state.tree:get_node()
                                local path = node:get_id()
                                vim.fn.setreg("+", path, "c")
                            end,
                            desc = "Copy Path to Clipboard",
                        },
                        ["P"] = { "toggle_preview", config = { use_float = false } },
                    },
                },
                default_component_configs = {
                    indent = {
                        with_expanders = true,
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    git_status = {
                        symbols = {
                            unstaged = "󰄱",
                            staged = "󰱒",
                        },
                    },
                },
            })
        end,
    },

    -- Statusline
    -- TODO: Customize sections
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "echasnovski/mini.icons",
        },
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
        dependencies = {
            "echasnovski/mini.icons",
        },
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts, {
                options = {
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "Neo-tree",
                            highlight = "Directory",
                            text_align = "left",
                            separator = true,
                        },
                    },
                    color_icons = true,
                },
                highlights = require("catppuccin.special.bufferline").get_theme()
            })
        end,
        keys = {
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            {
                "<Leader>dc",
                function()
                    Snacks.bufdelete()
                end,
                desc = "Delete Current Buffer",
            },
            { "<Leader>dr", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers on the Right" },
            { "<Leader>dl", "<Cmd>BufferLineCloseLeft<CR>",  desc = "Delete Buffers on the Left" },
        },
    },

    -- Icons
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = function(_, opts)
            require("mini.icons").mock_nvim_web_devicons()
            return vim.tbl_deep_extend("force", opts, {
                file = {
                    [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                    ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
                },
                filetype = {
                    dotenv = { glyph = "", hl = "MiniIconsYellow" },
                },
            })
        end,
    },

    -- Noice notification
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        },
    },
}
