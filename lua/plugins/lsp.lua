return {
    -- Lsp config
    {
        "neovim/nvim-lspconfig",
        event = "BufEdit",
        config = vim.schedule_wrap(function(_, opts)
            Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer) vim.lsp.inlay_hint.enable(true, { bufnr = buffer }) end)
            Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
                vim.lsp.codelens.refresh({ bufnr = buffer })
                vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
                    buffer = buffer, --[[@type integer]]
                    callback = function() vim.lsp.codelens.refresh({ bufnr = buffer }) end,
                })
            end)
            for server, config in pairs(opts.servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        end),
    },
}
