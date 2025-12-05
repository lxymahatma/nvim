---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "qmljs",
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                { "qmlls", condition = { missing = "qmlls" } },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                qmlls = {},
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                qml = { "qmlformat" },
            },
        },
    },
}
