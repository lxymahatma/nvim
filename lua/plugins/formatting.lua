-- Formatter
---@type LazyPluginSpec
return {
    "stevearc/conform.nvim",
    event = "BufEdit",

    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = require("helpers.parsers").get_formatters(),
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = function()
            if vim.g.disable_autoformat or vim.b.disable_autoformat then return nil end
            return { timeout_ms = 500 }
        end,
    },
}
