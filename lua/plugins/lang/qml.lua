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
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "qmlls",
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
}
