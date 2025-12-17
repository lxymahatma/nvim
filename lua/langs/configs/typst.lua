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
    on_attach_buf = function(bufnr)
        vim.bo[bufnr].spelllang = "en_us"

        vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, silent = true, expr = true, buffer = bufnr })
        vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, silent = true, expr = true, buffer = bufnr })
    end,
    on_attach_win = function(winid)
        vim.wo[winid].wrap = true
        vim.wo[winid].linebreak = true
        vim.wo[winid].breakindent = true
        vim.wo[winid].spell = true
    end,
}
