-- Code Completion
return {
    --- @type LazyPluginSpec
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        version = "*",

        --- @type blink.cmp.Config
        opts = {
            appearance = { nerd_font_variant = "normal" },
            cmdline = {
                enabled = true,
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            },
            term = {
                enabled = false,
                keymap = { preset = "inherit" },
            },
            completion = {
                keyword = { range = "full" },
                accept = {
                    auto_brackets = { enabled = true },
                },
                menu = {
                    auto_show = true,
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = { enabled = true },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    markdown = { inherit_defaults = true, "markview" },
                },
                providers = {
                    markview = { module = "blink-markview" },
                },
            },
            keymap = {
                preset = "none",
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<Tab>"] = {
                    "select_and_accept",
                    function() return require("copilot.suggestion").accept() end,
                    "fallback",
                },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            },
        },
    },

    -- Completion Icon and Highlighting
    --- @type LazyPluginSpec
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            local mini_icons = require("mini.icons")
            local colorful_menu = require("colorful-menu")

            opts.completion.menu.draw.components = vim.tbl_extend("force", opts.completion.menu.draw.components or {}, {
                kind_icon = {
                    ellipsis = false,
                    text = function(ctx)
                        local icon = ctx.kind_icon
                        if ctx.source_id == "lsp" then
                            if ctx.kind == "File" then
                                icon, _ = mini_icons.get("file", ctx.item.detail)
                            elseif ctx.kind == "Folder" then
                                icon, _ = mini_icons.get("directory", ctx.item.label)
                            else
                                icon, _ = mini_icons.get("lsp", ctx.kind)
                            end
                        elseif ctx.source_id == "path" then
                            if ctx.item.data.type ~= "link" then
                                icon, _ = mini_icons.get(ctx.item.data.type, ctx.label)
                            end
                        end

                        return icon .. ctx.icon_gap
                    end,
                    highlight = function(ctx)
                        local hl = ctx.kind_hl
                        if ctx.source_id == "lsp" then
                            if ctx.kind == "File" then
                                _, hl = mini_icons.get("file", ctx.item.detail)
                            elseif ctx.kind == "Folder" then
                                _, hl = mini_icons.get("directory", ctx.item.label)
                            else
                                _, hl = mini_icons.get("lsp", ctx.kind)
                            end
                        elseif ctx.source_id == "path" then
                            if ctx.item.data.type ~= "link" then
                                _, hl = mini_icons.get(ctx.item.data.type, ctx.label)
                            end
                        end

                        return hl
                    end,
                },
                label = {
                    text = function(ctx) return colorful_menu.blink_components_text(ctx) end,
                    highlight = function(ctx) return colorful_menu.blink_components_highlight(ctx) end,
                },
            })
        end,
    },
}
