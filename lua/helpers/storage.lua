local M = {}

local constant = require("config.constant")

local function json_path(key) return constant.storage_dir .. "/" .. key .. ".json" end
local function mpack_path(key) return constant.storage_dir .. "/" .. key .. ".mpack" end

function M.init()
    local storage_dir = constant.storage_dir
    if vim.fn.isdirectory(storage_dir) == 0 then vim.fn.mkdir(storage_dir, "p") end
end

-----------
-- JSON ---
-----------

---Write table to JSON
--- @param key string
--- @param data table
function M.write_json(key, data)
    assert(key and key ~= "", "Key cannot be empty")
    assert(type(data) == "table", "Data must be a table")

    local path = json_path(key)
    local ok, json = pcall(vim.json.encode, data)
    assert(ok, "Failed to encode JSON: " .. tostring(json))

    local f = assert(io.open(path, "w"), "Failed to open file: " .. path)
    f:write(json)
    f:close()
end

---Read table from JSON
--- @param key string
--- @return table
function M.read_json(key)
    assert(key and key ~= "", "Key cannot be empty")

    local path = json_path(key)
    assert(vim.fn.filereadable(path) == 1, "JSON file not found: " .. path)

    local f = assert(io.open(path, "r"))
    local content = f:read("*all")
    f:close()

    return vim.json.decode(content)
end

---Check if JSON file exists
--- @param key string
--- @return boolean
function M.exists_json(key)
    if not key or key == "" then return false end
    return vim.fn.filereadable(json_path(key)) == 1
end

------------------
-- MessagePack ---
------------------

---Write table to MessagePack
--- @param key string
--- @param data table
function M.write_mpack(key, data)
    assert(key and key ~= "", "Key cannot be empty")
    assert(type(data) == "table", "Data must be a table")

    local path = mpack_path(key)
    local encoded = vim.mpack.encode(data)

    local f = assert(io.open(path, "wb"), "Failed to open file: " .. path)
    f:write(encoded)
    f:close()
end

---Read table from MessagePack
--- @param key string
--- @return table
function M.read_mpack(key)
    assert(key and key ~= "", "Key cannot be empty")

    local path = mpack_path(key)
    assert(vim.fn.filereadable(path) == 1, "MsgPack file not found: " .. path)

    local f = assert(io.open(path, "rb"))
    local bytes = f:read("*all")
    f:close()

    return vim.mpack.decode(bytes)
end

---Check if MessagePack file exists
--- @param key string
--- @return boolean
function M.exists_mpack(key)
    if not key or key == "" then return false end
    return vim.fn.filereadable(mpack_path(key)) == 1
end

return M
