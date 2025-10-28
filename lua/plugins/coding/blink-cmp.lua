-- Code Completion
return {
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = "rafamadriz/friendly-snippets",
        version = "*",

        ---@type blink.cmp.Config
        opts = {
            appearance = { nerd_font_variant = "normal" },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
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
                default = { "lsp", "path", "snippets", "buffer", "markdown" },
                providers = {
                    markdown = {
                        name = "RenderMarkdown",
                        module = "render-markdown.integ.blink",
                        fallbacks = { "lsp" },
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<Tab>"] = { "select_and_accept", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            },
        },
    },

    -- Completion Icon and Highlighting
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            local mini_icons = require("mini.icons")
            local highlight_colors = require("nvim-highlight-colors")
            local colorful_menu = require("colorful-menu")

            opts.completion.menu.draw.components = vim.tbl_extend("force", opts.completion.menu.draw.components or {}, {
                kind_icon = {
                    ellipsis = false,
                    text = function(ctx)
                        local icon
                        if ctx.source_name == "Path" then
                            icon, _ = mini_icons.get(ctx.item.data.type, ctx.label)
                            return icon .. ctx.icon_gap
                        elseif ctx.source_name == "LSP" then
                            local color_item = highlight_colors.format(ctx.item.documentation, { kind = ctx.kind })
                            if color_item and color_item.abbr then return color_item.abbr .. ctx.icon_gap end
                            icon, _ = mini_icons.get("lsp", ctx.kind)
                            return icon .. ctx.icon_gap
                        else
                            return ctx.kind_icon .. ctx.icon_gap
                        end
                    end,
                    highlight = function(ctx)
                        local hl
                        if ctx.source_name == "Path" then
                            _, hl = mini_icons.get(ctx.item.data.type, ctx.label)
                            return hl
                        elseif ctx.source_name == "LSP" then
                            local color_item = highlight_colors.format(ctx.item.documentation, { kind = ctx.kind })
                            if color_item and color_item.abbr_hl_group then return color_item.abbr_hl_group end
                            _, hl = mini_icons.get("lsp", ctx.kind)
                            return hl
                        else
                            return ctx.kind_hl
                        end
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
