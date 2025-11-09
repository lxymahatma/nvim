return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "c_sharp",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "csharp_ls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                csharp_ls = {},
            },
        },
    },
}
