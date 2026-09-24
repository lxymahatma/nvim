-- catppuccin
---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,

  ---@type CatppuccinOptions
  opts = {
    flavour = "mocha",
    integrations = {
      noice = true,
    },
  },
}
