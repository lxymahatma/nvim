local M = {}

local constant = require("config.constant")

---Get the file path for a given type
---@param type string The storage type/key
---@return string
local function get_file_path(type) return constant.storage_dir .. "/" .. type .. ".json" end

---Setup the storage directory
function M.setup()
    local storage_dir = constant.storage_dir
    if vim.fn.isdirectory(storage_dir) == 0 then vim.fn.mkdir(storage_dir, "p") end
end

---Save data to local storage
---@param key string The storage type/key
---@param data table The data to save
function M.save(key, data)
    assert(key and key ~= "", "Type cannot be empty")
    assert(type(data) == "table", "Data must be a table")

    local filepath = get_file_path(key)
    local json_str = vim.json.encode(data)

    local file = assert(io.open(filepath, "w"), "Failed to open file for writing: " .. filepath)
    file:write(json_str)
    file:close()
end

---Load data from local storage
---@param key string The storage type/key
---@return table data The loaded data
function M.load(key)
    assert(key and key ~= "", "Type cannot be empty")

    local filepath = get_file_path(key)
    assert(vim.fn.filereadable(filepath) == 1, "File not found: " .. filepath)

    local file = assert(io.open(filepath, "r"), "Failed to open file for reading: " .. filepath)
    local content = file:read("*all")
    file:close()

    assert(content and content ~= "", "File is empty: " .. filepath)

    return vim.json.decode(content)
end

---Delete storage file for a given type
---@param type string The storage type/key
function M.delete(type)
    assert(type and type ~= "", "Type cannot be empty")

    local filepath = get_file_path(type)
    if vim.fn.filereadable(filepath) == 0 then return end
    assert(os.remove(filepath), "Failed to delete file: " .. filepath)
end

---Check if storage exists for a given type
---@param type string The storage type/key
---@return boolean exists Whether the storage exists
function M.exists(type)
    if type == nil or type == "" then return false end

    local filepath = get_file_path(type)
    return vim.fn.filereadable(filepath) == 1
end

return M
