-- Outline
--- @type LazyPluginSpec
return {
    "stevearc/aerial.nvim",
    opts = {
        autojump = true,
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        lazy_load = true,
        layout = {
            min_width = 0.3,
            max_width = 0.4,
        },
        filter_kind = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
        },
        show_guides = true,
    },
    keys = {
        { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial Toggle" },
    },
}
