local icons = require("config.icons").toolchain

local Header = {}

--- @param state ToolchainState
--- @param tabs { key: ToolchainTab, label: string }[]
--- @return ToolchainRenderChunk
function Header.render(state, tabs)
    local lines = { "" }
    local highlights = {}

    local tab_line = "  "
    for index, tab in ipairs(tabs) do
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

        if index < #tabs then tab_line = tab_line .. " " end
    end

    table.insert(lines, tab_line)
    table.insert(lines, string.rep("─", state.width - 2))

    return {
        lines = lines,
        highlights = highlights,
    }
end

return Header
