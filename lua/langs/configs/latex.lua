--- @type LanguageSpec
return {
    filetype = "tex",
    treesitter = true,
    mason = {
        "texlab",
        "tex-fmt",
    },
    lsp = "texlab",
    formatter = "tex-fmt",
    plugin = {
        "lervag/vimtex",
        lazy = false,
        init = function() vim.g.vimtex_view_method = "zathura" end,
    },
}
