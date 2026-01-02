--- @type LanguageSpec
return {
    treesitter = true,
    mason = {
        "ty",
        "ruff",
    },
    lsp = "ty",
    linter = "ruff",
    formatter = "ruff",
}
