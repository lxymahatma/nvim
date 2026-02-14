local api = vim.api

local Renderer = require("toolchain.ui.renderer")
local State = require("toolchain.ui.state")
local Keymaps = require("toolchain.ui.keymaps")
local CursorSync = require("toolchain.ui.cursor")

--- @class ToolchainUI
--- @field buf integer?
--- @field win integer?
--- @field state ToolchainState
local UI = {}
UI.__index = UI
setmetatable(UI, {
    __call = function(_, ...) return UI.new(...) end,
})

--- @param opts? ToolchainUIOptions
--- @return ToolchainUI
function UI.new(opts)
    local self = setmetatable({}, UI)
    self.state = State(opts)

    return self
end

--- @return void
function UI:render() Renderer.render({ buf = self.buf, win = self.win, state = self.state }) end

--- @return void
function UI:toggle_item()
    local item, message = self.state:toggle_current()
    if not item then
        vim.notify(message, vim.log.levels.WARN)
        return
    end

    self:render()
    vim.notify(message, vim.log.levels.INFO)
end

--- @param tab ToolchainTab
--- @return void
function UI:switch_tab(tab)
    self.state:switch_tab(tab)
    self:render()
end

--- @param delta integer
--- @return void
function UI:move_cursor(delta)
    if self.state:move_cursor(delta) then self:render() end
end

--- @return void
function UI:setup_keymaps() Keymaps.attach(self) end

--- @return void
function UI:attach_cursor_sync() CursorSync.attach(self) end

--- @return void
function UI:close()
    self.state:save()
    if self.win and api.nvim_win_is_valid(self.win) then api.nvim_win_close(self.win, true) end
    self.win = nil
    self.buf = nil
end

--- @return self
function UI:open()
    self.buf = api.nvim_create_buf(false, true)
    api.nvim_set_option_value("bufhidden", "wipe", { buf = self.buf })
    api.nvim_set_option_value("filetype", "toolchain", { buf = self.buf })

    local editor_ui = api.nvim_list_uis()[1]
    self.state:update_window_size(editor_ui)
    local width = self.state.window_width
    local height = self.state.window_height
    local row = (editor_ui.height - height) / 2
    local col = (editor_ui.width - width) / 2

    self.win = api.nvim_open_win(self.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = " Toolchain ",
        title_pos = "center",
    })

    api.nvim_set_option_value("cursorline", true, { win = self.win })
    api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual", { win = self.win })

    self:setup_keymaps()
    self:render()
    self:attach_cursor_sync()

    api.nvim_create_autocmd("BufLeave", {
        buffer = self.buf,
        once = true,
        callback = function() self:close() end,
    })

    return self
end

return UI
