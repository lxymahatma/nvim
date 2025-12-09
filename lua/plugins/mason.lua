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
                local lang_packages = require("helpers.lang-parser").get_mason_packages()
                local tool_packages = require("helpers.tool-parser").get_mason_packages()
                local packages = vim.list_extend(vim.deepcopy(lang_packages), tool_packages)

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
