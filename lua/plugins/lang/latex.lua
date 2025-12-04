---@type LazyPluginSpec[]
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
        "mason-org/mason.nvim",
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
