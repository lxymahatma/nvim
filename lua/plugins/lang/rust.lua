return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "rust",
                "ron",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "rust_analyzer",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                rust_analyzer = {},
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
            },
        },
    },
}
