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

M.default_tools = {}

M.storage_dir = vim.fn.stdpath("data") .. "/storage"
M.lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/lang"
M.tool_dir = vim.fn.stdpath("config") .. "/lua/plugins/tools"

return M
