local constant = require("config.constant")

local M = {}

local function json_path(key) return constant.storage_dir .. "/" .. key .. ".json" end

function M.init()
    local storage_dir = constant.storage_dir
    if vim.fn.isdirectory(storage_dir) == 0 then vim.fn.mkdir(storage_dir, "p") end
end

---Write table to JSON
---@param key string
---@param data table
function M.write_json(key, data)
    local path = json_path(key)
    local ok, json = pcall(vim.json.encode, data, { indent = "  ", sort_keys = true })
    assert(ok, "Failed to encode JSON: " .. tostring(json))

    local f = assert(io.open(path, "w"), "Failed to open file: " .. path)
    f:write(json)
    f:close()
end

---Read table from JSON
---@param key string
---@return table
function M.read_json(key)
    local path = json_path(key)
    local f = assert(io.open(path, "r"), "JSON file not found: " .. path)
    local content = f:read("*all")
    f:close()

    return vim.json.decode(content)
end

---Check if JSON file exists
---@param key string
---@return boolean
function M.exists_json(key)
    if not key or key == "" then return false end
    return vim.fn.filereadable(json_path(key)) == 1
end

return M
