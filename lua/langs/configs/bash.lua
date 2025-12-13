---@type LanguageSpec
return {
    filetype = "sh",
    treesitter = true,
    mason = {
        "bashls",
        "shellcheck",
        "shfmt",
    },
    lsp = "bashls",
    linter = "shellcheck",
    formatter = "shfmt",
}
