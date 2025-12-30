---@type LanguageSpec
return {
    treesitter = {
        "go",
        "gomod",
        "gowork",
        "gosum",
    },
    mason = {
        "gopls",
        "golangci-lint",
    },
    lsp = "gopls",
    linter = "golangcilint",
    formatter = "gofumpt",
}
