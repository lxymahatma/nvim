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
        deactivate = function() vim.cmd([[Neotree close]]) end,
        init = function()
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then require("neo-tree") end
        end,
        opts = function(_, opts)
            local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED, handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
            return vim.tbl_deep_extend("force", opts, {
                sources = { "filesystem", "buffers", "git_status" },
                open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                    },
                    follow_current_file = { enabled = true },
                },
                use_libuv_file_watcher = true,
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
                    icon = {
                        provider = function(icon, node)
                            local text, hl
                            local mini_icons = require("mini.icons")
                            if node.type == "file" then
                                text, hl = mini_icons.get("file", node.name)
                            elseif node.type == "directory" then
                                text, hl = mini_icons.get("directory", node.name)
                                if node:is_expanded() then text = nil end
                            end

                            if text then icon.text = text end
                            if hl then icon.highlight = hl end
                        end,
                    },
                    kind_icon = {
                        provider = function(icon, node)
                            icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
                        end,
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
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "<Leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin Buffer" },
            {
                "<Leader>bd",
                function() Snacks.bufdelete() end,
                desc = "Delete Current Buffer",
            },
            { "<Leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers on the Right" },
            { "<Leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers on the Left" },
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
}
