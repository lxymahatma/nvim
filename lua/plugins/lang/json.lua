return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "json",
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "jsonls",
                "jsonlint",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jsonls = {},
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                json = { "jsonlint" },
            },
        },
    },
}
