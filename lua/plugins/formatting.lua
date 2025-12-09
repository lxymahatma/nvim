-- Formatter
---@type LazyPluginSpec
return {
    "stevearc/conform.nvim",
    event = "BufEdit",
    opts = function()
        ---@type conform.setupOpts
        return {
            formatters_by_ft = require("helpers.lang-parser").get_formatters(),
            default_format_opts = {
                lsp_format = "last",
            },
            format_on_save = function()
                if vim.g.disable_autoformat or vim.b.disable_autoformat then return nil end
                return { timeout_ms = 500 }
            end,
        }
    end,
}
