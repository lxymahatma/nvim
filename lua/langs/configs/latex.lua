---@type LanguageSpec
return {
    filetype = "tex",
    treesitter = true,
    mason = "texlab",
    lsp = "texlab",
    plugin = {
        "lervag/vimtex",
        ft = "tex",
        init = function() vim.g.vimtex_view_method = "zathura" end,
    },
}
