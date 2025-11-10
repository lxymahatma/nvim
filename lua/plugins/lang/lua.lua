return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "luadoc",
                "luap",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "emmylua_ls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                emmylua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                extensions = { ".lua" },
                                requirePattern = {
                                    "lua/?.lua",
                                    "lua/?/init.lua",
                                },
                            },
                            workspace = {
                                library = {
                                    "$VIMRUNTIME",
                                    "$HOME/.local/share/nvim/lazy",
                                },
                            },
                        },
                    },
                },
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "selene",
                "stylua",
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                lua = { "selene" },
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
        },
    },
}
