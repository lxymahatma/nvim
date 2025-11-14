return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "json",
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "jsonls",
                "jsonlint",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jsonls = {},
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                json = { "jsonlint" },
            },
        },
    },
}
