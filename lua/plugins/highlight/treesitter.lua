-- Syntax Highlighting
---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufEdit", "VeryLazy" },
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
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        vim.defer_fn(function() require("helpers.treesitter").ensure_parser_installed(opts.ensure_installed) end, 100)
    end,
}
