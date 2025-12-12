---@type LanguageSpec
return {
    treesitter = {
        "c",
        "cpp",
    },
    mason = {
        { "clangd",       condition = { missing = true } },
        { "clang-format", condition = { missing = true } },
    },
    lsp = {
        clangd = {
            capabilities = {
                offsetEncoding = { "utf-8", "utf-16" },
                textDocument = {
                    completion = {
                        editsNearCursor = true,
                    },
                },
            },
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
            },
        },
    },
    formatter = {
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
    plugin = {
        "p00f/clangd_extensions.nvim",
        lazy = true,
    },
}
