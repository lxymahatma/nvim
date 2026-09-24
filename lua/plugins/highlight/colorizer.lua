---@type LazyPluginSpec
return {
  "catgoose/nvim-colorizer.lua",
  event = "BufEdit",
  opts = {
    filetypes = {
      "*",

      css = {
        parsers = {
          css = true,
          tailwind = { enable = true, lsp = true, update_names = true },
        },
      },

      sass = {
        parsers = {
          css = true,
          sass = { enable = true },
        },
      },

      scss = {
        parsers = {
          css = true,
          sass = { enable = true },
        },
      },

      html = {
        parsers = {
          css = true,
        },
      },

      javascriptreact = {
        parsers = {
          css = true,
          tailwind = { enable = true, lsp = true, update_names = true },
        },
      },

      typescriptreact = {
        parsers = {
          css = true,
          tailwind = { enable = true, lsp = true, update_names = true },
        },
      },

      qml = {
        parsers = {
          hex = { default = true, rrggbbaa = false, hash_aarrggbb = true },
        },
      },
    },

    options = {
      parsers = {
        names = {
          enable = false,
          lowercase = false,
          camelcase = false,
        },
        -- `default = true` turns on every hex format that isn't set explicitly
        hex = { default = true },
      },
    },
  },
}
