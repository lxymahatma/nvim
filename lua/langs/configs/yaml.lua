--- @type LanguageSpec
return {
    treesitter = true,
    mason = {
        "yamlls",
        "yamllint",
        "yamlfmt",
    },
    lsp = "yamlls",
    linter = "yamllint",
    formatter = "yamlfmt",
}
