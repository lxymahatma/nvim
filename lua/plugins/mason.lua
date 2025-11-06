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
        opts_extend = { "ensure_installed" },

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

    -- Mason Tools
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "VeryLazy",
        opts_extend = { "ensure_installed" },
        opts = {
            auto_update = true,
            run_on_start = true,
        },
    },
}
