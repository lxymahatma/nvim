---@type LanguageSpec
return {
  filetype = {
    "json",
    "jsonc",
    "json5",
  },
  treesitter = {
    "json",
    "json5",
  },
  mason = {
    "jsonls",
    "jsonlint",
  },
  lsp = "jsonls",
  -- jsonlint rejects comments, so keep it off jsonc/json5
  linter = { json = "jsonlint" },
}
