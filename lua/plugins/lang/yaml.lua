return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "yaml",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "yamlls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                yamlls = {},
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "yamllint",
                "yamlfmt",
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                yaml = { "yamllint" },
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                yaml = { "yamlfmt" },
            },
        },
    },
}
