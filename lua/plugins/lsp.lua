-- Lsp config
---@type LazyPluginSpec
return {
    "neovim/nvim-lspconfig",
    event = "BufEdit",
    config = function()
        Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
            ---@cast buffer integer
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end)
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
            ---@cast buffer integer
            vim.lsp.codelens.refresh({ bufnr = buffer })
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
                buffer = buffer,
                callback = function() vim.lsp.codelens.refresh({ bufnr = buffer }) end,
            })
        end)

        local lang_servers = require("langs.lang-parser").get_lsp_servers()
        local tool_servers = require("tools.tool-parser").get_lsp_servers()
        local servers = vim.tbl_extend("force", lang_servers, tool_servers)

        for server, config in pairs(servers) do
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
    end,
}
