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
    on_attach = function(bufnr)
        vim.bo[bufnr].spelllang = "en_us"

        vim.wo.wrap = true
        vim.wo.linebreak = true
        vim.wo.breakindent = true
        vim.wo.spell = true

        vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, silent = true, expr = true, buffer = bufnr })
        vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, silent = true, expr = true, buffer = bufnr })
    end,
}
