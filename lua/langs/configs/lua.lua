--- @type LanguageSpec
return {
    treesitter = {
        "lua",
        "luadoc",
        "luap",
    },
    mason = {
        "emmylua_ls",
        "selene",
        "stylua",
    },
    lsp = {
        emmylua_ls = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        extensions = { ".lua" },
                        requirePattern = {
                            "lua/?.lua",
                            "lua/?/init.lua",
                        },
                    },
                    workspace = {
                        library = {
                            "$VIMRUNTIME",
                            "$HOME/.local/share/nvim/lazy",
                        },
                    },
                },
            },
        },
    },
    linter = "selene",
    formatter = { "stylua", lsp_format = "last" },
}
