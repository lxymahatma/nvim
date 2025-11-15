return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
        local colors = require("plugins.ui.heirline.colors").colors
        local tabline = require("plugins.ui.heirline.tabline")
        local statusline = require("plugins.ui.heirline.statusline")
        local winbar = require("plugins.ui.heirline.winbar")

        require("heirline").setup({
            statusline = statusline.setup(),
            winbar = winbar.setup(colors),
            tabline = tabline.setup(colors),
            opts = {
                colors = colors,
                disable_winbar_cb = function(args) return not require("helpers.window").is_edit_window() end,
            },
        })
    end,
    keys = {
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
