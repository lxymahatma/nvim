return {
    -- TODO: Finish Configuration
    {
        "mfussenegger/nvim-lint",
        event = "BufEdit",
        init = function()
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                    require("lint").try_lint("cspell")
                end,
            })
        end,
    },
}
