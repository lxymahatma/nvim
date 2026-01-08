-- Syntax Highlighting
--- @type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufEdit", "VeryLazy" },
    build = ":TSUpdate",
    opts = {},
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)

        vim.defer_fn(function()
            local parsers = vim.list_extend(require("config.constant").default_parsers, require("toolchain.lang.parser").get_treesitter_parsers())
            require("helpers.treesitter").ensure_parsers_installed(parsers)
        end, 100)
    end,
}
