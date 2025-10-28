return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "dockerfile",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "docker_compose_language_service",
                "docker_language_server",
                "dockerls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                docker_compose_language_service = {},
                docker_language_server = {},
                dockerls = {},
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                dockerfile = { "hadolint" },
            },
        },
    },
}
