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

M.default_tools = {}

M.storage_dir = vim.fn.stdpath("data") .. "/storage"
M.lang_dir = vim.fn.stdpath("config") .. "/lua/langs/configs"
M.tool_dir = vim.fn.stdpath("config") .. "/lua/tools/configs"
M.picker_dir = vim.fn.stdpath("config") .. "/lua/config/pickers"

return M
