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
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                yaml = { "yamlfmt" },
            },
        },
    },
}
