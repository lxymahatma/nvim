-- Formatter
---@type LazyPluginSpec
return {
    "stevearc/conform.nvim",
    event = "BufEdit",
    opts = function()
        local lang_formatters = require("langs.lang-parser").get_formatters()
        local tool_formatters = require("tools.tool-parser").get_formatters()
        local formatters_by_ft = vim.tbl_extend("force", lang_formatters, tool_formatters)

        ---@type conform.setupOpts
        return {
            formatters_by_ft = formatters_by_ft,
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
