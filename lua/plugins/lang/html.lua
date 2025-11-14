return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "html",
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "html",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                html = {},
            },
        },
    },
}
