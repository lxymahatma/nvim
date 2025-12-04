-- Syntax Highlighting
---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufEdit", "VeryLazy" },
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "diff",
            "query",
            "regex",
            "vim",
            "vimdoc",
        },
    },
}
