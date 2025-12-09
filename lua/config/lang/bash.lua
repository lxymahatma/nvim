---@type LanguageSpec
return {
    treesitter = true,
    mason = {
        "bashls",
        "shellcheck",
        "shfmt",
    },
    lsp = "bashls",
    linter = {
        sh = { "shellcheck" },
    },
    formatter = {
        sh = { "shfmt" },
    },
}
