return {
    -- Mason
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts_extend = { "ensure_installed" },

        ---@type MasonSettings
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
        config = function(_, opts)
            require("mason").setup(opts)
            vim.defer_fn(function() require("helpers.mason").ensure_packages_installed(opts.ensure_installed) end, 100)
        end,
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
    },

    -- Mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = "VeryLazy",

        ---@type MasonLspconfigSettings
        opts = {
            automatic_enable = false,
        },
    },
}
