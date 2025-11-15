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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "emmylua_ls",
                "selene",
                "stylua",
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
