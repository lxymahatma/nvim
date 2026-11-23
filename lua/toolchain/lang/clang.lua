---@type LanguageSpec
return {
  filetype = {
    "c",
    "cpp",
  },
  treesitter = {
    "c",
    "cpp",
  },
  mason = {
    "clice",
    { "clang-format", condition = { missing = true } },
  },
  lsp = "clice",
  formatter = "clang-format",
}
