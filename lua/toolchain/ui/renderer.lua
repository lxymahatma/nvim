local api = vim.api

local icons = require("config.icons").toolchain
local ns = api.nvim_create_namespace("toolchain_ui")

local tabs = {
    { key = "all",  label = "All" },
    { key = "lang", label = "Lang" },
    { key = "tool", label = "Tool" },
}

local Renderer = {}

--- @param buf integer
--- @param row integer
--- @param col_start integer
--- @param col_end integer
--- @param hl_group string
local function set_hl(buf, row, col_start, col_end, hl_group)
    api.nvim_buf_set_extmark(buf, ns, row, col_start, {
        end_col = col_end,
        hl_group = hl_group,
    })
end

--- @param text string
--- @param width integer
local function center(text, width)
    local padding = math.floor((width - vim.fn.strdisplaywidth(text)) / 2)
    return string.rep(" ", padding) .. text
end

--- @param state ToolchainState
--- @return string[], {line: integer, col_start: integer, col_end: integer, hl: string}[]
local function render_header(state)
    local lines = { "" }
    local highlights = {}

    local tab_line = "  "
    for i, tab in ipairs(tabs) do
        local count = state:count_by_tab(tab.key)
        local enabled_count = state:count_enabled_by_tab(tab.key)
        local is_active = state.current_tab == tab.key
        local icon = is_active and icons.tab_active or icons.tab_inactive

        local start_col = #tab_line
        local tab_text = string.format(" %s %s (%d/%d) ", icon, tab.label, enabled_count, count)
        tab_line = tab_line .. tab_text

        table.insert(highlights, {
            line = 1,
            col_start = start_col,
            col_end = #tab_line,
            hl = is_active and "ToolchainTabActive" or "ToolchainTabInactive",
        })

        if i < #tabs then tab_line = tab_line .. " " end
    end

    table.insert(lines, tab_line)
    table.insert(lines, string.rep("─", state.width - 2))

    return lines, highlights
end

--- @param state ToolchainState
--- @return string[], {line: integer, col_start: integer, col_end: integer, hl: string}[]
local function render_items(state)
    local lines = {}
    local highlights = {}

    for i, item in ipairs(state.filtered_items) do
        local icon = item.enabled and icons.enabled or icons.disabled
        local type_label = item.type == "lang" and "Lang" or "Tool"
        local default_mark = item.is_default and (" " .. icons.default) or ""

        local line = string.format("  %s  %-20s  [%s]%s", icon, item.name, type_label, default_mark)
        table.insert(lines, line)

        local icon_hl = item.enabled and "ToolchainEnabled" or "ToolchainDisabled"
        local type_hl = item.type == "lang" and "ToolchainTypeLang" or "ToolchainTypeTool"
        local type_start = 28
        local type_end = type_start + #type_label + 2

        table.insert(highlights, { line = i, col_start = 2, col_end = 5, hl = icon_hl })
        table.insert(highlights, { line = i, col_start = 6, col_end = 26, hl = "ToolchainName" })
        table.insert(highlights, { line = i, col_start = type_start, col_end = type_end, hl = type_hl })

        if item.is_default then table.insert(highlights, { line = i, col_start = type_end, col_end = type_end + #default_mark, hl = "ToolchainDefault" }) end
    end

    return lines, highlights
end

--- @param state ToolchainState
--- @return string[]
local function render_footer(state)
    local help_text = "<CR> Toggle  q Close"
    return {
        string.rep("─", state.width - 2),
        center(help_text, state.width),
        "",
    }
end

--- @param ctx ToolchainRenderContext
function Renderer.render(ctx)
    local buf, win, state = ctx.buf, ctx.win, ctx.state
    if not buf or not api.nvim_buf_is_valid(buf) then return end

    api.nvim_set_option_value("modifiable", true, { buf = buf })

    local header_lines, header_hl = render_header(state)
    local item_lines, item_hl = render_items(state)
    local footer_lines = render_footer(state)

    local all_lines = {}
    vim.list_extend(all_lines, header_lines)
    vim.list_extend(all_lines, item_lines)

    local content_height = #header_lines + #item_lines + #footer_lines
    local padding = state.height - content_height - 2
    for _ = 1, padding do
        table.insert(all_lines, "")
    end

    vim.list_extend(all_lines, footer_lines)
    api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)

    api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    for _, hl in ipairs(header_hl) do
        set_hl(buf, hl.line, hl.col_start, hl.col_end, hl.hl)
    end

    local header_offset = #header_lines
    state.header_offset = header_offset

    for _, hl in ipairs(item_hl) do
        set_hl(buf, header_offset + hl.line - 1, hl.col_start, hl.col_end, hl.hl)
    end

    api.nvim_set_option_value("modifiable", false, { buf = buf })

    local cursor_line = header_offset + state.cursor_line
    if win and api.nvim_win_is_valid(win) then
        local ok, current = pcall(api.nvim_win_get_cursor, win)
        if not ok or current[1] ~= cursor_line then pcall(api.nvim_win_set_cursor, win, { cursor_line, 0 }) end
    end
end

return Renderer
