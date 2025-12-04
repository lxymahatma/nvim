local M = {}

---@param tbl string[]
---@return table<string, boolean>
function M.to_set(tbl)
    local lookup = {}
    for _, name in ipairs(tbl) do
        lookup[name] = true
    end
    return lookup
end

return M
