return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "rust",
                "ron",
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                { "rust_analyzer", condition = function() return not vim.fn.executable("rust-analyzer") == 1 end },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                rust_analyzer = {},
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
            },
        },
    },
}
