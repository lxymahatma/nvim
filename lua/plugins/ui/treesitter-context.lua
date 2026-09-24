-- Show code context
---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufEdit",

  ---@type TSContext.Config
  opts = {
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
  },
}
