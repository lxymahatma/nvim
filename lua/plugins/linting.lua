-- Linter
--- @type LazyPluginSpec
return {
    "mfussenegger/nvim-lint",
    event = "BufEdit",
    opts = {},
    config = function()
        require("lint").linters_by_ft = require("toolchain").get_linters()

        local events = {
            "BufReadPost",
            "BufWritePost",
            "InsertLeave",
            "TextChanged",
        }

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
            callback = debounce(100, function() require("lint").try_lint() end),
        })
    end,
}
