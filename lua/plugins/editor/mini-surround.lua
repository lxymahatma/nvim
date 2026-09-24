-- Fast and feature-rich surround actions
---@type LazyPluginSpec
return {
  "nvim-mini/mini.surround",
  event = "BufEdit",
  opts = {
    mappings = {
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "", -- Highlight surrounding
    },
  },
}
