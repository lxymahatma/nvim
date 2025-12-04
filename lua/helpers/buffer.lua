local M = {}

---@param direction "left"|"right"
function M.close_buffers(direction)
    local current_buf = vim.api.nvim_get_current_buf()
    local buffers = require("tabscope").get_buflist()
    local current_idx = nil

    for i, buf in ipairs(buffers) do
        if buf == current_buf then
            current_idx = i
            break
        end
    end

    if not current_idx then return end

    local targets = {}

    if direction == "left" then
        for i = 1, current_idx - 1 do
            targets[buffers[i]] = true
        end
    elseif direction == "right" then
        for i = current_idx + 1, #buffers do
            targets[buffers[i]] = true
        end
    end

    if next(targets) == nil then return end

    Snacks.bufdelete({
        filter = function(buf) return targets[buf] end,
    })
end

return M
