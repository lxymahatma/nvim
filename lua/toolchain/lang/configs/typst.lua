---@type LanguageSpec
return {
  treesitter = true,
  mason = {
    "tinymist",
    "typstyle",
  },
  lsp = "tinymist",
  formatter = "typstyle",
  plugin = {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    opts = {
      debug = false,
      invert_colors = "auto",
      dependencies_bin = {
        ["tinymist"] = "tinymist",
        ["websocat"] = "websocat",
      },
    },
  },
  keymaps = {
    { mode = "n", lhs = "k", rhs = "v:count == 0 ? 'gk' : 'k'", opts = { expr = true, silent = true } },
    { mode = "n", lhs = "j", rhs = "v:count == 0 ? 'gj' : 'j'", opts = { expr = true, silent = true } },
  },
  on_attach = function(bufnr)
    vim.bo[bufnr].spelllang = "en_us"

    vim.wo[0][0].wrap = true
    vim.wo[0][0].linebreak = true
    vim.wo[0][0].breakindent = true
    vim.wo[0][0].spell = true
  end,
}
