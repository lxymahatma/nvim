--- @type LanguageSpec
return {
    treesitter = {
        "json",
        "json5",
    },
    mason = {
        "jsonls",
        "jsonlint",
    },
    lsp = "jsonls",
    linter = "jsonlint",
}
