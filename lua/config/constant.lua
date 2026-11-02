local M = {}

M.default_parsers = {
  "diff",
  "query",
  "regex",
  "vim",
  "vimdoc",
}

M.default_langs = {
  "bash",
  "git",
  "json",
  "html",
  "ini",
  "latex",
  "lua",
  "markdown",
  "nushell",
  "toml",
  "xml",
  "yaml",
}

M.default_tools = {
  "harper",
}

---@type ToolchainTypeConfig[]
M.toolchain_types = {
  { name = "lang", defaults = M.default_langs },
  { name = "tool", defaults = M.default_tools },
}

M.storage_dir = vim.fn.stdpath("data") .. "/storage"

M.picker_dir = vim.fn.stdpath("config") .. "/lua/config/pickers"

M.filetypes = {
  web = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
}

return M
