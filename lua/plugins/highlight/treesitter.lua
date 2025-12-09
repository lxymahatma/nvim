-- Syntax Highlighting
---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufEdit", "VeryLazy" },
    build = ":TSUpdate",
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)

        vim.defer_fn(function()
            local parsers = vim.list_extend(require("config.constant").default_parsers, require("helpers.lang-parser").get_treesitter_parsers())
            require("helpers.treesitter").ensure_parsers_installed(parsers)
        end, 100)
    end,
}
