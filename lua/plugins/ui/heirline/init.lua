return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
        local colors = require("plugins.ui.heirline.colors")
        local tabline = require("plugins.ui.heirline.tabline")
        local statusline = require("plugins.ui.heirline.statusline")
        local winbar = require("plugins.ui.heirline.winbar")

        require("heirline").setup({
            statusline = statusline.setup(colors),
            winbar = winbar.setup(colors),
            tabline = tabline.setup(colors),
            opts = {
                disable_winbar_cb = function(args) return not require("helpers.window").is_edit_window() end,
                colors = colors.get(),
            },
        })
    end,
    keys = {
        {
            "<leader>bp",
            function()
                vim.b.pinned = not vim.b.pinned
                print("Buffer " .. (vim.b.pinned and "pinned" or "unpinned"))
            end,
            desc = "Toggle Pin Buffer",
        },
        {
            "<leader>br",
            function()
                local buffers = vim.tbl_filter(function(bufnr) return vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) end, vim.api.nvim_list_bufs())

                local current = vim.api.nvim_get_current_buf()
                local current_idx = nil
                for i, bufnr in ipairs(buffers) do
                    if bufnr == current then
                        current_idx = i
                        break
                    end
                end

                if current_idx and current_idx < #buffers then
                    for i = current_idx + 1, #buffers do
                        vim.api.nvim_buf_delete(buffers[i], { force = false })
                    end
                end
            end,
            desc = "Delete Buffers on the Right",
        },
        {
            "<leader>bl",
            function()
                local buffers = vim.tbl_filter(function(bufnr) return vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) end, vim.api.nvim_list_bufs())

                local current = vim.api.nvim_get_current_buf()
                local current_idx = nil
                for i, bufnr in ipairs(buffers) do
                    if bufnr == current then
                        current_idx = i
                        break
                    end
                end

                if current_idx and current_idx > 1 then
                    for i = 1, current_idx - 1 do
                        vim.api.nvim_buf_delete(buffers[i], { force = false })
                    end
                end
            end,
            desc = "Delete Buffers on the Left",
        },
    },
}
