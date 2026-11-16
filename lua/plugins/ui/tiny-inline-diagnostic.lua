-- Inline diagnostic messages
---@type LazyPluginSpec
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  opts = {
    preset = "classic",
    disabled_ft = { "lazy" },
    options = {
      show_source = {
        enabled = true,
      },
      multilines = {
        enabled = true,
        always_show = true,
      },
    },
  },
}
