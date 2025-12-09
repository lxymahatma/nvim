---@type LanguageSpec
return {
    treesitter = {
        "json",
        "jsonc",
        "json5",
    },
    mason = {
        "jsonls",
        "jsonlint",
    },
    lsp = "jsonls",
    linter = "jsonlint",
}
