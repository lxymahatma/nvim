return {
    -- Lsp config
    {
        "neovim/nvim-lspconfig",
        event = "BufEdit",
        config = vim.schedule_wrap(function(_, opts)
            Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
                ---@cast buffer integer
                vim.lsp.codelens.refresh({ bufnr = buffer })
                vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
                    buffer = buffer,
                    callback = function() vim.lsp.codelens.refresh({ bufnr = buffer }) end,
                })
            end)
            for server, config in pairs(opts.servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        end),
    },

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
}
