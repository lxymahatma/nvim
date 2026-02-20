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
    formatter_opts = {
        yamlfmt = {
            append_args = { "--indent-size", "2", "-formatter", "retain_line_breaks=true" },
        },
    },
}
