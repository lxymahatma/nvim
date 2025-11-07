return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "bashls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                bashls = {},
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "shellcheck",
                "shfmt",
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                bash = { "shellcheck" },
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
            },
        },
    },
}
