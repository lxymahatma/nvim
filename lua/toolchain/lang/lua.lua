---@type LanguageSpec
return {
  treesitter = {
    "lua",
    "luadoc",
    "luap",
  },
  mason = {
    "emmylua_ls",
    "luafmt",
  },
  lsp = {
    emmylua_ls = {
      settings = {
        emmylua = {
          runtime = {
            version = "LuaJIT",
            extensions = { ".lua" },
            requirePattern = {
              "?.lua",
              "?/init.lua",
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          workspace = {
            library = vim.list_extend(
              { "$VIMRUNTIME", "$NVIM_DEV_DIR" },
              vim.tbl_map(function(path)
                return {
                  path = path,
                  ignoreGlobs = {
                    "**/*_spec.lua",
                    "**/scripts/**",
                    "**/test/**",
                    "**/tests/**",
                    "**/spec/**",
                  },
                }
              end, vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy", "*/lua", false, true))
            ),
          },
        },
      },
    },
  },
  formatter = { "luafmt" },
}
