local M = {}

--- @generic T
--- @param list T[]
--- @return table<T, boolean>
function M.to_set(list)
    local lookup = {}

    for _, name in ipairs(list) do
        lookup[name] = true
    end
    return lookup
end

--- @generic T
--- @param ... T[]
--- @return T[]
function M.list_merge(...)
    local result = {}
    local args = { ... }

    for _, list in ipairs(args) do
        vim.list_extend(result, list)
    end
    return result
end

return M
