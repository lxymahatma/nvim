---@type LanguageSpec
return {
    treesitter = "bash",
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
