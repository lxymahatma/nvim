-- Noice notification
---@type LazyPluginSpec
return {
    "folke/noice.nvim",
    event = "VeryLazy",

    ---@type NoiceConfig
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
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
}
