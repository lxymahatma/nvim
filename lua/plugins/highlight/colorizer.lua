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
                    hex = { default = true, rrggbbaa = true, hash_aarrggbb = false },
                },
            },

            sass = {
                parsers = {
                    css = true,
                    sass = { enable = true, parsers = { css = true } },
                    hex = { default = true, rrggbbaa = true, hash_aarrggbb = false },
                },
            },

            scss = {
                parsers = {
                    css = true,
                    sass = { enable = true, parsers = { css = true } },
                    hex = { default = true, rrggbbaa = true, hash_aarrggbb = false },
                },
            },

            html = {
                parsers = {
                    css = true,
                    hex = { default = true, rrggbbaa = true, hash_aarrggbb = false },
                },
            },

            javascriptreact = {
                parsers = {
                    css = true,
                    tailwind = { enable = true, lsp = true, update_names = true },
                    hex = { default = true, rrggbbaa = true, hash_aarrggbb = false },
                },
            },

            typescriptreact = {
                parsers = {
                    css = true,
                    tailwind = { enable = true, lsp = true, update_names = true },
                    hex = { default = true, rrggbbaa = true, hash_aarrggbb = false },
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
                    enabled = false,
                    lowercase = false,
                    camelcase = false,
                    uppercase = false,
                    strip_digits = false,
                },
                hex = {
                    default = true,
                    rgb = true,
                    rgba = true,
                    rrggbb = true,
                    rrggbbaa = true,
                    hash_aarrggbb = false,
                    aarrggbb = true,
                    no_hash = false,
                },
            },
            display = {
                disable_document_color = true,
            },
        },
    },
}
