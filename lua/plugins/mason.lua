return {
    -- Mason
    {
        "mason-org/mason.nvim",
        cmd = "Mason",

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
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
    },

    -- Mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        event = "VeryLazy",

        ---@type MasonLspconfigSettings
        opts = {
            automatic_enable = false,
        },
    },

    -- Mason DAP
    {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },

        ---@type MasonNvimDapSettings
        opts = {
            automatic_installation = true,
        },
    },

    -- Mason Install Tool
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "VeryLazy",
        opts_extend = { "ensure_installed" },
        opts = {
            auto_update = true,
            integrations = {
                ["mason-lspconfig"] = true,
                ["mason-null-ls"] = true,
                ["mason-nvim-dap"] = true,
            },
        },
    },
}
