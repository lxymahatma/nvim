local api = vim.api

local ns = api.nvim_create_namespace("toolchain_ui")

local icons = {
    enabled = "",
    disabled = "",
    default = "★",
    tab_active = "●",
    tab_inactive = "○",
}

local Renderer = {}

local function set_hl(buf, hl_group, row, col_start, col_end)
    api.nvim_buf_set_extmark(buf, ns, row, col_start, {
        end_col = col_end ~= -1 and col_end or nil,
        end_row = col_end == -1 and row or nil,
        hl_group = hl_group,
    })
end

local function render_header(state)
    local lines = {}
    local highlights = {}

    table.insert(lines, "")

    local tabs = {
        { key = "all",  label = "All" },
        { key = "lang", label = "Lang" },
        { key = "tool", label = "Tool" },
    }

    local tab_line = "  "
    local tab_positions = {}

    for i, tab in ipairs(tabs) do
        local count = state:count_by_tab(tab.key)
        local enabled_count = state:count_enabled_by_tab(tab.key)
        local is_active = state.current_tab == tab.key
        local icon = is_active and icons.tab_active or icons.tab_inactive

        local start_col = #tab_line
        local tab_text = string.format(" %s %s (%d/%d) ", icon, tab.label, enabled_count, count)
        tab_line = tab_line .. tab_text

        table.insert(tab_positions, {
            start_col = start_col,
            end_col = #tab_line,
            is_active = is_active,
        })

        if i < #tabs then tab_line = tab_line .. " " end
    end

    table.insert(lines, tab_line)
    table.insert(highlights, { line = 1, positions = tab_positions })
    table.insert(lines, string.rep("─", state.width - 2))

    return lines, highlights
end

local function render_items(state)
    local lines = {}
    local highlights = {}

    for i, item in ipairs(state.filtered_items) do
        local icon = item.enabled and icons.enabled or icons.disabled
        local type_label = item.type == "lang" and "Lang" or "Tool"

        local parts = {}
        local ranges = {}
        local offset = 0

        local function append(text, range_key)
            if text == "" then return end
            table.insert(parts, text)
            local len = #text
            if range_key then
                ranges[range_key] = { start_col = offset, end_col = offset + len }
            end
            offset = offset + len
        end

        append("  ")
        append(icon .. "  ", "icon")
        append(string.format("%-20s", item.name), "name")
        append("  ")
        append("[" .. type_label .. "]", "type")
        if item.is_default then append(" " .. icons.default, "default") end

        local line = table.concat(parts)
        table.insert(lines, line)
        table.insert(highlights, { line = i, item = item, ranges = ranges })
    end

    return lines, highlights
end

local function render_footer(state)
    return {
        string.rep("─", state.width - 2),
        "  <CR> Toggle  <Tab> Switch Tab  1/2/3 Jump Tab  q Close",
        "",
    }
end

function Renderer.render(ctx)
    local buf, win, state = ctx.buf, ctx.win, ctx.state
    if not buf or not api.nvim_buf_is_valid(buf) then return end

    api.nvim_set_option_value("modifiable", true, { buf = buf })

    local all_lines = {}
    local header_lines, header_hl = render_header(state)
    local item_lines, item_hl = render_items(state)
    local footer_lines = render_footer(state)

    vim.list_extend(all_lines, header_lines)
    vim.list_extend(all_lines, item_lines)

    local content_height = #header_lines + #item_lines + #footer_lines
    local padding_needed = state.height - content_height - 2
    for _ = 1, padding_needed do
        table.insert(all_lines, "")
    end

    vim.list_extend(all_lines, footer_lines)
    api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)

    api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    for _, hl in ipairs(header_hl) do
        if hl.positions then
            for _, pos in ipairs(hl.positions) do
                local hl_group = pos.is_active and "ToolchainTabActive" or "ToolchainTabInactive"
                set_hl(buf, hl_group, hl.line, pos.start_col, pos.end_col)
            end
        end
    end

    local header_offset = #header_lines
    for _, hl in ipairs(item_hl) do
        local line_idx = header_offset + hl.line - 1
        local ranges = hl.ranges or {}
        if hl.item then
            local icon_hl = hl.item.enabled and "ToolchainEnabled" or "ToolchainDisabled"
            local type_hl = hl.item.type == "lang" and "ToolchainTypeLang" or "ToolchainTypeTool"

            if ranges.icon then set_hl(buf, icon_hl, line_idx, ranges.icon.start_col, ranges.icon.end_col) end
            if ranges.name then set_hl(buf, "ToolchainName", line_idx, ranges.name.start_col, ranges.name.end_col) end
            if ranges.type then set_hl(buf, type_hl, line_idx, ranges.type.start_col, ranges.type.end_col) end
            if hl.item.is_default and ranges.default then
                set_hl(buf, "ToolchainDefault", line_idx, ranges.default.start_col, ranges.default.end_col)
            end
        end
    end

    local footer_line = #all_lines - 2
    set_hl(buf, "ToolchainFooter", footer_line, 0, -1)

    api.nvim_set_option_value("modifiable", false, { buf = buf })

    local cursor_line = #header_lines + state.cursor_line
    --- @cast cursor_line integer
    if win and api.nvim_win_is_valid(win) then pcall(api.nvim_win_set_cursor, win, { cursor_line, 0 }) end
end

return Renderer
