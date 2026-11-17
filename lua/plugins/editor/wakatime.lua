---@type LazyPluginSpec
return {
  "wakatime/vim-wakatime",
  event = "VeryLazy",
  init = function() vim.g.loaded_wakatime = 1 end,
  opts = {},
}
