local api = vim.api

local Layout = require("toolchain.ui.renderer.layout")
local Header = require("toolchain.ui.renderer.sections.header")
local Items = require("toolchain.ui.renderer.sections.items")
local Footer = require("toolchain.ui.renderer.sections.footer")

local ns = api.nvim_create_namespace("toolchain_ui")

local tabs = {
    { key = "all", label = "All" },
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

--- @param layout ToolchainLayout
--- @param buf integer
local function apply_layout(layout, buf)
    local all_lines = layout:get_lines()
    api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)
    api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    for _, hl in ipairs(layout:get_highlights()) do
        set_hl(buf, hl.line, hl.col_start, hl.col_end, hl.hl)
    end
end

--- @param ctx ToolchainRenderContext
function Renderer.render(ctx)
    local buf, win, state = ctx.buf, ctx.win, ctx.state
    if not buf or not api.nvim_buf_is_valid(buf) then return end

    api.nvim_set_option_value("modifiable", true, { buf = buf })

    local layout = Layout.new()
    local header_lines_appended = layout:append(Header.render(state, tabs))
    layout:append(Items.render(state))

    state.header_offset = header_lines_appended

    local footer_chunk = Footer.render(state)
    local content_height = layout:line_count() + #footer_chunk.lines
    local padding = state.height - content_height - 2
    layout:pad(padding)
    layout:append(footer_chunk)

    apply_layout(layout, buf)
    api.nvim_set_option_value("modifiable", false, { buf = buf })

    local cursor_line = state.header_offset + state.cursor_line
    if win and api.nvim_win_is_valid(win) then
        local ok, current = pcall(api.nvim_win_get_cursor, win)
        if not ok or current[1] ~= cursor_line then pcall(api.nvim_win_set_cursor, win, { cursor_line, 0 }) end
    end
end

return Renderer
