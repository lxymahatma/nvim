return {
    {
        "mfussenegger/nvim-lint",
        event = "BufEdit",
        init = function()
            local events = { "BufReadPost", "BufWritePost", "InsertLeave" }
            local function debounce(ms, fn)
                local timer = vim.uv.new_timer()
                return function()
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)()
                    end)
                end
            end

            vim.api.nvim_create_autocmd(events, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = debounce(100, function()
                    require("lint").try_lint()
                    require("lint").try_lint("cspell")
                end),
            })
        end,
    },
}
