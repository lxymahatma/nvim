return {
    -- Lsp config
    {
        "neovim/nvim-lspconfig",
        event = "BufEdit",
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
                vim.lsp.config(server, config)
            end
        end,
    },

    -- Mason
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            keymaps = {
                toggle_package_expand = "l",
                toggle_package_install_log = "l",
            },
        },
    },

    -- Mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        event = "BufEdit",
        opts_extend = { "ensure_installed" },
        opts = {},
        config = vim.schedule_wrap(function(_, opts) require("mason-lspconfig").setup(opts) end),
    },
}
