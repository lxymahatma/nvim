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
                { "qmlls", condition = function() return not vim.fn.executable("qmlls") == 1 end },
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

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                qml = { "qmlformat" },
            },
        },
    },
}
