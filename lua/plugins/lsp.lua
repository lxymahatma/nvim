return {
    -- Lsp config
    {
        "neovim/nvim-lspconfig",
        event = "BufEdit",
        config = function(_, opts)
            for server, config in pairs(opts.servers) do
                vim.lsp.config(server, config)
            end
            Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer) vim.lsp.inlay_hint.enable(true, { bufnr = buffer }) end)
            Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
                ---@cast buffer integer
                vim.lsp.codelens.refresh({ bufnr = buffer })
                vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
                    buffer = buffer,
                    callback = function() vim.lsp.codelens.refresh({ bufnr = buffer }) end,
                })
            end)
        end,
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
        event = "BufEdit",
        opts_extend = { "ensure_installed" },
        opts = {},
        config = vim.schedule_wrap(function(_, opts) require("mason-lspconfig").setup(opts) end),
    },
}
