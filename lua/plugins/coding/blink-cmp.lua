-- Code Completion
return {
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },
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
                ["<Tab>"] = {
                    "select_and_accept",
                    function() return require("copilot.suggestion").accept() end,
                    function() return require("sidekick").nes_jump_or_apply() end,
                    "fallback",
                },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["C-p"] = { "select_prev", "fallback_to_mappings" },
                ["C-n"] = { "select_next", "fallback_to_mappings" },
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
                        local icon = ctx.kind_icon
                        if ctx.source_id == "lsp" then
                            if ctx.kind == "File" then
                                icon, _ = mini_icons.get("file", ctx.item.detail)
                            elseif ctx.kind == "Folder" then
                                icon, _ = mini_icons.get("directory", ctx.item.label)
                            elseif ctx.kind == "Color" and ctx.item.documentation then
                                local color_item = highlight_colors.format(ctx.item.documentation, { kind = "Color" })
                                if color_item and color_item.abbr then icon = color_item.abbr end
                            else
                                icon, _ = mini_icons.get("lsp", ctx.kind)
                            end
                        elseif ctx.source_id == "path" then
                            icon, _ = mini_icons.get(ctx.item.data.type, ctx.label)
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
                            elseif ctx.kind == "Color" and ctx.item.documentation then
                                local color_item = highlight_colors.format(ctx.item.documentation, { kind = "Color" })
                                if color_item and color_item.abbr then hl = color_item.abbr_hl_group end
                            else
                                _, hl = mini_icons.get("lsp", ctx.kind)
                            end
                        elseif ctx.source_id == "path" then
                            _, hl = mini_icons.get(ctx.item.data.type, ctx.label)
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
        config = function(_, opts)
            require("blink.cmp").setup(opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "BlinkCmpMenuOpen",
                callback = function() vim.b.copilot_suggestion_hidden = true end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "BlinkCmpMenuClose",
                callback = function() vim.b.copilot_suggestion_hidden = false end,
            })
        end,
    },
}
