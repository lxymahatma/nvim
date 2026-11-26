---@type LanguageSpec
return {
  filetype = "dockerfile",
  treesitter = "dockerfile",
  mason = {
    "docker_language_server",
    "dockerls",
    "hadolint",
  },
  lsp = {
    "docker_language_server",
    "dockerls",
  },
  linter = "hadolint",
}
