return {
    -- Lsp config
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
        },
        opts = {
            inlay_hints = {
                enabled = true,
            },
            codelens = {
                enabled = false,
            }
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<Leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },

    -- Mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        opts = {
            automatic_installation = true,
        }
    },
}
