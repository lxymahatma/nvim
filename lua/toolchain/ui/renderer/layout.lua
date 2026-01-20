--- @class ToolchainLayout
--- @field lines string[]
--- @field highlights ToolchainRenderHighlight[]
local Layout = {}
Layout.__index = Layout

--- @return ToolchainLayout
function Layout.new()
    return setmetatable({
        lines = {},
        highlights = {},
    }, Layout)
end

--- @param chunk ToolchainRenderChunk?
--- @return integer
function Layout:append(chunk)
    if not chunk or not chunk.lines then return 0 end

    local start_line = #self.lines
    for _, line in ipairs(chunk.lines) do
        table.insert(self.lines, line)
    end

    if chunk.highlights then
        for _, hl in ipairs(chunk.highlights) do
            table.insert(self.highlights, {
                line = start_line + hl.line,
                col_start = hl.col_start,
                col_end = hl.col_end,
                hl = hl.hl,
            })
        end
    end

    return #chunk.lines
end

--- @param count integer
function Layout:pad(count)
    for _ = 1, math.max(0, count) do
        table.insert(self.lines, "")
    end
end

--- @return integer
function Layout:line_count()
    return #self.lines
end

--- @return string[]
function Layout:get_lines()
    return self.lines
end

--- @return ToolchainRenderHighlight[]
function Layout:get_highlights()
    return self.highlights
end

return Layout
