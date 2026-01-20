local icons = require("config.icons").toolchain

local Items = {}

--- @param state ToolchainState
--- @return ToolchainRenderChunk
function Items.render(state)
    local lines = {}
    local highlights = {}

    for index, item in ipairs(state.filtered_items) do
        local icon = item.enabled and icons.enabled or icons.disabled
        local type_label = item.type == "lang" and "Lang" or "Tool"
        local default_mark = item.is_default and (" " .. icons.default) or ""

        local line = string.format("  %s  %-20s  [%s]%s", icon, item.name, type_label, default_mark)
        table.insert(lines, line)

        local icon_hl = item.enabled and "ToolchainEnabled" or "ToolchainDisabled"
        local type_hl = item.type == "lang" and "ToolchainTypeLang" or "ToolchainTypeTool"
        local type_start = 28
        local type_end = type_start + 7

        local line_index = index - 1
        table.insert(highlights, { line = line_index, col_start = 2, col_end = 5, hl = icon_hl })
        table.insert(highlights, { line = line_index, col_start = 6, col_end = 26, hl = "ToolchainName" })
        table.insert(highlights, { line = line_index, col_start = type_start, col_end = type_end, hl = type_hl })

        if item.is_default then
            table.insert(highlights, { line = line_index, col_start = type_end, col_end = type_end + #default_mark, hl = "ToolchainDefault" })
        end
    end

    return {
        lines = lines,
        highlights = highlights,
    }
end

return Items
