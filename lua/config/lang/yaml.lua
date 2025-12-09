---@type LanguageSpec
return {
    treesitter = "yaml",
    mason = {
        "yamlls",
        "yamllint",
        "yamlfmt",
    },
    lsp = "yamlls",
    linter = "yamllint",
    formatter = "yamlfmt",
}
