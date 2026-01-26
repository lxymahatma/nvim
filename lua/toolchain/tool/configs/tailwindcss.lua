--- @type ToolSpec
return {
    lsp = {
        tailwindcss = {
            filetypes = require("config.constant").filetypes.web,
        },
    },
    mason = "tailwindcss",
}
