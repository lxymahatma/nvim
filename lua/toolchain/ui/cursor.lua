local api = vim.api

local Cursor = {}

---@param ui ToolchainUI
local function sync_from_window(ui)
    if not (ui.win and api.nvim_win_is_valid(ui.win)) then return end

    local cursor = api.nvim_win_get_cursor(ui.win)
    local items = ui.state.filtered_items
    local total = #items

    local offset = ui.state.header_offset or 0
    local row = cursor[1] --[[@as integer]]
    local relative_line = row - offset
    if relative_line < 1 then
        relative_line = 1
    elseif relative_line > total then
        relative_line = total
    end

    if relative_line ~= ui.state.cursor_line then ui.state.cursor_line = relative_line end
end

---@param ui ToolchainUI
function Cursor.attach(ui)
    if not ui.buf or not api.nvim_buf_is_valid(ui.buf) then return end

    api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = ui.buf,
        callback = function() sync_from_window(ui) end,
    })
end

return Cursor
