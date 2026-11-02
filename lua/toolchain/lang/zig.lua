---@type LanguageSpec
return {
  treesitter = true,
  mason = { "zls", condition = { missing = true } },
  lsp = "zls",
}
