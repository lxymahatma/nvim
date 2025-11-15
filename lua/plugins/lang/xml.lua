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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
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
