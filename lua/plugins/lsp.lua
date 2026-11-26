-- Lsp config
---@type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  event = "BufEdit",
  dependencies = { "mason-org/mason.nvim" },
  config = vim.schedule_wrap(function()
    require("config.keymaps.lsp")

    vim.lsp.inlay_hint.enable(true)
    vim.lsp.codelens.enable(true)

    local servers = require("toolchain").get_lsp_servers()
    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
    end
    vim.lsp.enable(vim.tbl_keys(servers))
  end),
}
