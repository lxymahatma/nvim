-- Syntax Highlighting
---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufEdit", "VeryLazy" },
  build = ":TSUpdate",
  opts = {},
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    vim.defer_fn(function()
      local table_helper = require("helpers.table")
      local default_parsers = require("config.constant").default_parsers
      local parsers = table_helper.list_merge(default_parsers, require("toolchain").get_treesitter_parsers())
      require("helpers.treesitter").ensure_parsers_installed(parsers)
    end, 100)
  end,
}
