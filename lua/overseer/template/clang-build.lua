---@type overseer.TemplateFileDefinition
return {
  name = "clang build",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "clang", file },
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = {
      "c",
      "cpp",
    },
  },
}
