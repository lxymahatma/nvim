return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "css",
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "cssls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                cssls = {},
            },
        },
    },
}
