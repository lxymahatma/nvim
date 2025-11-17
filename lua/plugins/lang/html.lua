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
        "mason-org/mason.nvim",
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
