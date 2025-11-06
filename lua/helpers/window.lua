local M = {}
function M.is_edit_window(win)
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then return false end
    local buf = vim.api.nvim_win_get_buf(win)
    return vim.bo[buf].buftype == ""
end

function M.has_multiple_edit_windows()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local count = 0
    for _, win in ipairs(wins) do
        if M.is_edit_window(win) then
            count = count + 1
            if count > 1 then return true end
        end
    end
    return false
end

return M
