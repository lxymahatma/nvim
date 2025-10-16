return {
    -- File Explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
        deactivate = function() vim.cmd([[Neotree close]]) end,
        init = function()
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then require("neo-tree") end
        end,
        opts = {
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
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
                    ["P"] = {
                        "toggle_preview",
                        config = {
                            use_float = false,
                            use_snacks_image = true,
                        },
                    },
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    never_show = {
                        ".DS_Store",
                    },
                },
                follow_current_file = { enabled = true },
            },
            use_libuv_file_watcher = true,
        },
        config = function(_, opts)
            local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED,   handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
            require("neo-tree").setup(opts)

            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function() require("neo-tree.sources.git_status").refresh() end,
            })
        end,
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ source = "filesystem", toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (Root Dir)",
            },
            {
                "<leader>ge",
                function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end,
                desc = "Git Explorer",
            },
            {
                "<leader>be",
                function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,
                desc = "Buffer Explorer",
            },
        },
    },

    -- File Operations with LSP
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-neo-tree/neo-tree.nvim",
        },
        opts = {},
    },

    -- Window Picker
    {
        "s1n7ax/nvim-window-picker",
        opts = {
            filter_rules = {
                include_current_win = false,
                autoselect_one = true,
                bo = {
                    filetype = { "neo-tree", "neo-tree-popup", "notify" },
                    buftype = { "terminal", "quickfix" },
                },
            },
        },
    },
}
