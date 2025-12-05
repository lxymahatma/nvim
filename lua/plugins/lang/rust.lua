---@type LazyPluginSpec[]
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
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                { "rust_analyzer", condition = { missing = "rust-analyzer" } },
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
