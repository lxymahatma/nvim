---@type LanguageSpec
return {
    treesitter = {
        "rust",
        "ron",
    },
    mason = { "rust_analyzer", condition = { missing = "rust-analyzer" } },
    lsp = "rust_analyzer",
    formatter = "rustfmt",
}
