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
        "gofumpt",
    },
    lsp = "gopls",
    formatter = "gofumpt",
    linter = "golangcilint",
}
