---@type LanguageSpec
return {
    treesitter = true,
    mason = "tinymist",
    lsp = "tinymist",
    plugin = {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        opts = {
            debug = false,
            invert_colors = "auto",
            dependencies_bin = {
                ["tinymist"] = "tinymist",
            },
        },
    },
}
