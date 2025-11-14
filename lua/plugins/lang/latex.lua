return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "latex",
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "texlab",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                texlab = {},
            },
        },
    },
}
