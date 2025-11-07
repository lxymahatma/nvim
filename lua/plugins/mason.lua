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

            local mr = require("mason-registry")
            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        vim.notify(("[mason.nvim] installing %s"):format(tool))
                        p:install(
                            {},
                            vim.schedule_wrap(function(success)
                                if success then
                                    vim.notify(("[mason.nvim] %s was successfully installed"):format(tool))
                                else
                                    vim.notify(
                                        ("[mason.nvim] failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(tool),
                                        vim.log.levels.ERROR
                                    )
                                end
                            end)
                        )
                    end
                end
            end)
        end,
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
}
