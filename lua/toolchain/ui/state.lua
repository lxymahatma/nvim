local loader = require("toolchain.loader")

--- @class ToolchainState
--- @field current_tab ToolchainTab
--- @field cursor_line integer
--- @field header_offset integer
--- @field dirty boolean
--- @field width ToolchainUISize
--- @field height ToolchainUISize
--- @field window_width integer
--- @field window_height integer
--- @field items ToolchainItem[]
--- @field filtered_items ToolchainItem[]
local State = {}
State.__index = State
setmetatable(State, {
    __call = function(_, ...) return State.new(...) end,
})

--- @param opts? ToolchainUIOptions
--- @return ToolchainState
function State.new(opts)
    opts = opts or {}

    local self = setmetatable({}, State)
    self.current_tab = "all"
    self.cursor_line = 1
    self.header_offset = 0
    self.dirty = false
    self.width = opts.width or 0.4
    self.height = opts.height or 0.8
    self.items = loader.get_items()
    self.filtered_items = self.items

    return self
end

--- @param editor_ui {width: integer, height: integer}
function State:update_window_size(editor_ui)
    --- @param value ToolchainUISize
    --- @param total integer
    --- @param fallback integer
    --- @return integer
    local function resolve_size(value, total, fallback)
        local size = value or fallback
        if size < 1 then size = math.floor(total * size) end
        size = math.floor(size)
        if size < 1 then size = 1 end
        if size > total then size = total end
        return size
    end

    local width = resolve_size(self.width, editor_ui.width, 100)
    local height = resolve_size(self.height, editor_ui.height, 40)

    self.window_width = width
    self.window_height = height
end

--- @return void
function State:filter_items()
    if self.current_tab == "all" then
        self.filtered_items = self.items
    else
        self.filtered_items = vim.tbl_filter(function(item) return item.type == self.current_tab end, self.items)
    end
end

--- @param tab ToolchainTab
--- @return integer
function State:count_by_tab(tab)
    if tab == "all" then return #self.items end
    return #vim.tbl_filter(function(item) return item.type == tab end, self.items)
end

--- @param tab ToolchainTab
--- @return integer
function State:count_enabled_by_tab(tab)
    local items = tab == "all" and self.items or vim.tbl_filter(function(item) return item.type == tab end, self.items)
    return #vim.tbl_filter(function(item) return item.enabled end, items)
end

--- @return ToolchainItem
function State:get_current_item()
    return self.filtered_items[self.cursor_line] --[[@as ToolchainItem]]
end

--- @return ToolchainItem?, string
function State:toggle_current()
    local item = self:get_current_item()

    if item.is_default then return nil, "Cannot disable default: " .. item.name end

    local type_key = item.type --[[@as string]]
    local extra = loader.extra[type_key]

    if item.enabled then
        loader.extra[type_key] = vim.tbl_filter(function(v) return v ~= item.name end, extra)
    else
        table.insert(extra, item.name)
    end

    item.enabled = not item.enabled
    self.dirty = true

    local action = item.enabled and "Enabled" or "Disabled"
    return item, string.format("%s %s. Restart Neovim to apply.", action, item.name)
end

--- @param tab ToolchainTab
function State:switch_tab(tab)
    self.current_tab = tab
    self.cursor_line = 1
    self:filter_items()
end

--- @param delta integer
--- @return boolean
function State:move_cursor(delta)
    local new_line = self.cursor_line + delta
    return self:set_cursor(new_line)
end

--- @param line integer
--- @return boolean
function State:set_cursor(line)
    if line < 1 or line > #self.filtered_items then return false end

    self.cursor_line = line
    return true
end

--- @return void
function State:save()
    if not self.dirty then return end
    loader.save()
    self.dirty = false
end

return State
