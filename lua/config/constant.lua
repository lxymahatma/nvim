local M = {}

M.default_langs = {
    "bash",
    "git",
    "json",
    "html",
    "latex",
    "lua",
    "markdown",
    "nushell",
    "toml",
    "xml",
    "yaml",
}

M.storage_dir = vim.fn.stdpath("data") .. "/storage"
M.lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/lang"

return M
