local M = {}

M.toolchain_types = {
    "lang",
    "tool",
}

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

M.picker_dir = vim.fn.stdpath("config") .. "/lua/config/pickers"

M.lang_dir = vim.fn.stdpath("config") .. "/lua/toolchain/lang/configs"
M.tool_dir = vim.fn.stdpath("config") .. "/lua/toolchain/tool/configs"

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
