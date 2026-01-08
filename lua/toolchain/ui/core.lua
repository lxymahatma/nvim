local api = vim.api

local Renderer = require("toolchain.ui.renderer")
local State = require("toolchain.ui.state")

local UI = {}
UI.__index = UI

---@param opts? {width?: integer, height?: integer}
---@return ToolchainUI
function UI.new(opts)
    local self = setmetatable({}, UI)
    self.state = State.new(opts)
    return self
end

--- @return void
function UI:render() Renderer.render({ buf = self.buf, win = self.win, state = self.state }) end

--- @return void
function UI:toggle_item()
    local item, message = self.state:toggle_current()
    if not item then
        if message then vim.notify(message, vim.log.levels.WARN) end
        return
    end

    self:render()
    if message then vim.notify(message, vim.log.levels.INFO) end
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
function UI:setup_keymaps()
    ---@cast self.buf integer
    local opts = { buffer = self.buf, nowait = true, silent = true }

    vim.keymap.set("n", "j", function() self:move_cursor(1) end, opts)
    vim.keymap.set("n", "k", function() self:move_cursor(-1) end, opts)
    vim.keymap.set("n", "<Down>", function() self:move_cursor(1) end, opts)
    vim.keymap.set("n", "<Up>", function() self:move_cursor(-1) end, opts)
    vim.keymap.set("n", "G", function()
        if self.state:set_cursor(#self.state.filtered_items) then self:render() end
    end, opts)
    vim.keymap.set("n", "gg", function()
        if self.state:set_cursor(1) then self:render() end
    end, opts)

    vim.keymap.set("n", "<CR>", function() self:toggle_item() end, opts)
    vim.keymap.set("n", "i", function() self:toggle_item() end, opts)
    vim.keymap.set("n", "x", function() self:toggle_item() end, opts)

    vim.keymap.set("n", "1", function() self:switch_tab("all") end, opts)
    vim.keymap.set("n", "2", function() self:switch_tab("lang") end, opts)
    vim.keymap.set("n", "3", function() self:switch_tab("tool") end, opts)

    vim.keymap.set("n", "q", function() self:close() end, opts)
    vim.keymap.set("n", "<Esc>", function() self:close() end, opts)

    vim.keymap.set("n", "R", function()
        self.state:load_items()
        self:render()
    end, opts)
end

function UI:close()
    if self.win and api.nvim_win_is_valid(self.win) then api.nvim_win_close(self.win, true) end
    self.win = nil
    self.buf = nil
end

---@return ToolchainUI
function UI:open()
    self.buf = api.nvim_create_buf(false, true)
    api.nvim_set_option_value("bufhidden", "wipe", { buf = self.buf })
    api.nvim_set_option_value("filetype", "toolchain", { buf = self.buf })

    local editor_ui = api.nvim_list_uis()[1]
    local row = math.floor((editor_ui.height - self.state.height) / 2)
    local col = math.floor((editor_ui.width - self.state.width) / 2)
    ---@cast row integer
    ---@cast col integer

    local width = self.state.width
    local height = self.state.height
    ---@cast width integer
    ---@cast height integer

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

    api.nvim_create_autocmd("BufLeave", {
        buffer = self.buf,
        once = true,
        callback = function() self:close() end,
    })

    return self
end

return UI
