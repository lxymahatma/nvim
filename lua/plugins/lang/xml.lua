---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "xml",
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "lemminx",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lemminx = {},
            },
        },
    },
}
