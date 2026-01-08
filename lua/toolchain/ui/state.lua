local constant = require("config.constant")
local lang_loader = require("toolchain.lang.loader")
local tool_loader = require("toolchain.tool.loader")

local State = {}
State.__index = State

--- @param opts? {width?: integer, height?: integer}
--- @return ToolchainState
function State.new(opts)
    opts = opts or {}
    local self = setmetatable({}, State)
    self.current_tab = "all"
    self.cursor_line = 1
    self.width = opts.width or 60
    self.height = opts.height or 20
    --- @cast self.width integer
    --- @cast self.height integer

    self:load_items()
    return self
end

--- @return void
function State:load_items()
    self.items = {}

    local all_langs = lang_loader.get_all_langs()
    local enabled_langs = lang_loader.get_enabled_langs()
    local default_langs = constant.default_langs

    for _, lang in ipairs(all_langs) do
        table.insert(self.items, {
            name = lang,
            type = "lang",
            enabled = vim.tbl_contains(enabled_langs, lang),
            is_default = vim.tbl_contains(default_langs, lang),
        })
    end

    local all_tools = tool_loader.get_all_tools()
    local enabled_tools = tool_loader.get_enabled_tools()
    local default_tools = constant.default_tools

    for _, tool in ipairs(all_tools) do
        table.insert(self.items, {
            name = tool,
            type = "tool",
            enabled = vim.tbl_contains(enabled_tools, tool),
            is_default = vim.tbl_contains(default_tools, tool),
        })
    end

    table.sort(self.items, function(a, b)
        if a.type ~= b.type then return a.type < b.type end
        return a.name < b.name
    end)

    self:filter_items()
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

--- @return ToolchainItem?
function State:get_current_item() return self.filtered_items[self.cursor_line] end

--- @return ToolchainItem?, string?
function State:toggle_current()
    local item = self:get_current_item()
    if not item then return end

    if item.is_default then return nil, "Cannot disable default: " .. item.name end

    if item.type == "lang" then
        local extra_langs = lang_loader.get_extra_langs()
        if item.enabled then
            extra_langs = vim.tbl_filter(function(v) return v ~= item.name end, extra_langs)
        else
            table.insert(extra_langs, item.name)
        end
        lang_loader.save_extra_langs(extra_langs)
    else
        local extra_tools = tool_loader.get_extra_tools()
        if item.enabled then
            extra_tools = vim.tbl_filter(function(v) return v ~= item.name end, extra_tools)
        else
            table.insert(extra_tools, item.name)
        end
        tool_loader.save_extra_tools(extra_tools)
    end

    item.enabled = not item.enabled
    local action = item.enabled and "Enabled" or "Disabled"
    return item, string.format("%s %s. Restart Neovim to apply.", action, item.name)
end

--- @param tab? ToolchainTab
function State:switch_tab(tab)
    if tab then
        self.current_tab = tab
    else
        local tabs = { "all", "lang", "tool" }
        local current_idx = 1
        for i, t in ipairs(tabs) do
            if t == self.current_tab then
                current_idx = i
                break
            end
        end
        self.current_tab = tabs[(current_idx % #tabs) + 1]
    end

    self.cursor_line = 1
    self:filter_items()
end

--- @return void
function State:switch_prev_tab()
    local tabs = { "all", "lang", "tool" }
    local current_idx = 1
    for i, t in ipairs(tabs) do
        if t == self.current_tab then
            current_idx = i
            break
        end
    end
    self.current_tab = tabs[((current_idx - 2) % #tabs) + 1]
    self.cursor_line = 1
    self:filter_items()
end

--- @param delta integer
--- @return boolean
function State:move_cursor(delta)
    local new_line = self.cursor_line + delta
    if new_line >= 1 and new_line <= #self.filtered_items then
        self.cursor_line = new_line
        return true
    end
    return false
end

--- @param line integer
--- @return boolean
function State:set_cursor(line)
    if line < 1 or line > #self.filtered_items then return false end
    self.cursor_line = line
    return true
end

return State
