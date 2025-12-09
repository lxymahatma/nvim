---@type LanguageSpec
return {
    treesitter = true,
    mason = {
        "pyrefly",
        "ruff",
    },
    lsp = "pyrefly",
    linter = "ruff",
    formatter = "ruff",
}
