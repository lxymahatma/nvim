-- Session Management
---@type LazyPluginSpec
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    {
      "<leader>wr",
      function() require("persistence").select() end,
      desc = "Session search",
    },
  },
}
