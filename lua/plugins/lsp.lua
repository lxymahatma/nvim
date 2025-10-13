return {
    -- Lsp config
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "mason-org/mason.nvim",
        },
        opts = {
            inlay_hints = {
                enabled = true,
            },
            codelens = {
                enabled = false,
            },
        },
        config = function(_, opts)
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        end,
    },

    -- Mason
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<Leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    -- Mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        event = "VeryLazy",
        opts_extend = { "ensure_installed" },
        opts = {},
    },
}
