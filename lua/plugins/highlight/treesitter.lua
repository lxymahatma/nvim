-- Syntax Highlighting
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
            "bash",
            "diff",
            "query",
            "regex",
            "vim",
            "vimdoc",
        },
    },
}
