local storage_helper = require("helpers.storage")

local M = {}

--- Get all modules from a directory
--- @param module_dir string
--- @return string[]
function M.get_all_modules(module_dir)
    local all_modules = {}

    for name in vim.fs.dir(module_dir) do
        table.insert(all_modules, name:sub(1, -5))
    end

    return all_modules
end

--- Get extra modules from storage
--- @param storage_key string
--- @return string[]
function M.get_extra_modules(storage_key)
    if storage_helper.exists_json(storage_key) then
        local ok, data = pcall(storage_helper.read_json, storage_key)
        if not ok then return {} end
        return data.extra_modules or {}
    end

    return {}
end

--- Get enabled modules (default + extra)
--- @param default_modules string[]
--- @param storage_key string
--- @return string[]
function M.get_enabled_modules(default_modules, storage_key)
    local extra_modules = M.get_extra_modules(storage_key)
    local enabled_modules = {}
    vim.list_extend(enabled_modules, default_modules)
    for _, module in ipairs(extra_modules) do
        if not vim.tbl_contains(enabled_modules, module) then table.insert(enabled_modules, module) end
    end
    return enabled_modules
end

--- Save extra modules to storage
--- @param storage_key string
--- @param extra_modules string[]
function M.save_extra_modules(storage_key, extra_modules)
    table.sort(extra_modules)
    local ok, err = pcall(storage_helper.write_json, storage_key, { extra_modules = extra_modules })
    if not ok then vim.notify("Failed to save module config: " .. tostring(err), vim.log.levels.ERROR) end
end

return M
