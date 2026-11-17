---@type LanguageSpec
return {
  treesitter = {
    "rust",
    "ron",
  },
  mason = {
    { "rust_analyzer", condition = { missing = "rust-analyzer" } },
    "codelldb",
  },
  formatter = "rustfmt",
  plugin = { "mrcjkb/rustaceanvim", ft = "rust" },
}
