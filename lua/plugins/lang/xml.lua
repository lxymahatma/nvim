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
        "mason-org/mason-lspconfig.nvim",
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
