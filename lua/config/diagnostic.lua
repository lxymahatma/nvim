local icon = require("config.icons").diagnostics

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icon.Error,
            [vim.diagnostic.severity.WARN] = icon.Warn,
            [vim.diagnostic.severity.HINT] = icon.Hint,
            [vim.diagnostic.severity.INFO] = icon.Info,
        },
    },
})
