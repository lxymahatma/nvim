---@type LanguageSpec
return {
    treesitter = "python",
    mason = {
        "pyrefly",
        "ruff",
    },
    lsp = "pyrefly",
    linter = "ruff",
    formatter = "ruff",
}
