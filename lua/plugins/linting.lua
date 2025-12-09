-- Linter
---@type LazyPluginSpec
return {
    "mfussenegger/nvim-lint",
    event = "BufEdit",
    opts = {},
    config = function()
        local lang_linters = require("helpers.lang-parser").get_linters()
        local tool_linters = require("helpers.tool-parser").get_linters()
        local linters_by_ft = vim.tbl_extend("force", lang_linters, tool_linters)

        require("lint").linters_by_ft = linters_by_ft

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
