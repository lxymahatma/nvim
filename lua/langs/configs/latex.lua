---@type LanguageSpec
return {
    treesitter = true,
    mason = "texlab",
    lsp = "texlab",
    plugin = {
        "lervag/vimtex",
        event = "VeryLazy",
        init = function() vim.g.vimtex_view_method = "zathura" end,
    },
}
