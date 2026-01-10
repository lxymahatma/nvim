local map = vim.keymap.set

local Keymaps = {}

---@param ui ToolchainUI
function Keymaps.attach(ui)
    local buf = ui.buf
    if not buf or not vim.api.nvim_buf_is_valid(buf) then return end

    local opts = { buffer = buf, nowait = true, silent = true }

    map("n", "j", function() ui:move_cursor(1) end, opts)
    map("n", "k", function() ui:move_cursor(-1) end, opts)
    map("n", "<Down>", function() ui:move_cursor(1) end, opts)
    map("n", "<Up>", function() ui:move_cursor(-1) end, opts)

    map("n", "G", function()
        if ui.state:set_cursor(#ui.state.filtered_items) then ui:render() end
    end, opts)

    map("n", "gg", function()
        if ui.state:set_cursor(1) then ui:render() end
    end, opts)

    map("n", "<CR>", function() ui:toggle_item() end, opts)

    map("n", "1", function() ui:switch_tab("all") end, opts)
    map("n", "2", function() ui:switch_tab("lang") end, opts)
    map("n", "3", function() ui:switch_tab("tool") end, opts)

    local function close() ui:close() end
    map("n", "q", close, opts)
    map("n", "<Esc>", close, opts)
end

return Keymaps
