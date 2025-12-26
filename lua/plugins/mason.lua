---@type LazyPluginSpec[]
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
        config = function(_, opts)
            require("mason").setup(opts)

            vim.defer_fn(function()
                local packages = require("helpers.parsers").get_mason_packages()
                require("helpers.mason").ensure_packages_installed(packages)
            end, 100)
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
