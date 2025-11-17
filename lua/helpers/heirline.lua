local utils = require("heirline.utils")

local M = {}

--- @param destination table
--- @param child table
--- @return table
function M.insert_first(destination, child)
    local new = utils.clone(destination)
    local new_child = utils.clone(child)
    table.insert(new, 1, new_child)
    return new
end

--- @param destination table
--- @param child table
--- @return table
function M.insert_last(destination, child)
    local new = utils.clone(destination)
    local new_child = utils.clone(child)
    table.insert(new, new_child)
    return new
end

return M
