local icon = require("config.icons")

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icon.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icon.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icon.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icon.diagnostics.Info,
        },
    },
})
