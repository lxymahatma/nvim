return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "c",
                "cpp",
            }
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
            }
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
                                editsNearCursor = true
                            }
                        }
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                    },
                }
            }
        }
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
        }
    }
}
