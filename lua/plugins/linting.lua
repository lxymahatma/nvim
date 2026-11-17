-- Linter
---@type LazyPluginSpec
return {
  "mfussenegger/nvim-lint",
  event = "BufEdit",
  config = function()
    require("lint").linters_by_ft = require("toolchain").get_linters()

    local events = {
      "BufReadPost",
      "BufWritePost",
      "InsertLeave",
      "TextChanged",
    }

    vim.api.nvim_create_autocmd(events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = Snacks.util.debounce(function() require("lint").try_lint() end, { ms = 100 }),
    })
  end,
}
