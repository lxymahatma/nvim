---@type LazyPluginSpec
return {
  "saghen/blink.pairs",
  event = "BufEdit",
  version = "*",
  dependencies = "saghen/blink.lib",
  build = function() require("blink.pairs").download():pwait(60000) end,

  ---@type blink.pairs.Config
  opts = {
    highlights = {
      groups = {
        "BlinkPairsRed",
        "BlinkPairsYellow",
        "BlinkPairsBlue",
        "BlinkPairsOrange",
        "BlinkPairsGreen",
        "BlinkPairsPurple",
        "BlinkPairsCyan",
      },
      matchparen = {
        group = "BlinkPairsMatchParen",
      },
    },
  },
}
