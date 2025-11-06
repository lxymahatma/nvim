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

M.local_config_path = vim.fn.stdpath("data") .. "/local.lua"
M.lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/lang"

return M
