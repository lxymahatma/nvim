---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "c",
                "cpp",
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                { "clangd", condition = function() return not vim.fn.executable("clangd") == 1 end },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
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
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
        },
    },
}
