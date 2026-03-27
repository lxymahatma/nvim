---@type LanguageSpec
return {
    treesitter = "qmljs",
    mason = { "qmlls", condition = { missing = true } },
    lsp = "qmlls",
}
