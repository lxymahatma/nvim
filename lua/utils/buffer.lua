local M = {}

---@param direction "left"|"right"
function M.close_buffers(direction)
    local current = vim.api.nvim_get_current_buf()
    local current_idx, buffers = nil, {}

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then
            buffers[#buffers + 1] = bufnr
            if bufnr == current then current_idx = #buffers end
        end
    end

    if not current_idx then return end

    if direction == "left" then
        for i = current_idx - 1, 1, -1 do
            vim.api.nvim_buf_delete(buffers[i], { force = false })
        end
    else
        for i = current_idx + 1, #buffers do
            vim.api.nvim_buf_delete(buffers[i], { force = false })
        end
    end
end

return M
