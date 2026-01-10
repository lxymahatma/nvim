local constant = require("config.constant")
local module_loader = require("helpers.module-loader")
local table_helper = require("helpers.table")

--- @class ToolchainLoader
--- @field items ToolchainItem[]
--- @field enabled table<ToolchainType, string[]>
--- @field extra table<ToolchainType, string[]>
local M = {
    items = {},
    enabled = {},
    extra = {},
}

--- @return void
function M.load()
    M.items = {}
    M.enabled = {}
    M.extra = {}

    for _, type_name in ipairs(constant.toolchain_types) do
        local dir = constant[type_name .. "_dir"] --[[@as string]]
        local defaults = constant["default_" .. type_name .. "s"] --[[@as string[] ]]
        local extra = module_loader.get_extra_modules(type_name)

        M.extra[type_name] = extra
        M.enabled[type_name] = table_helper.list_merge(defaults, extra)

        local all = module_loader.get_all_modules(dir)
        local enabled_set = table_helper.to_set(M.enabled[type_name])

        for _, name in ipairs(all) do
            table.insert(M.items, {
                name = name,
                type = type_name,
                enabled = enabled_set[name] or false,
                is_default = vim.tbl_contains(defaults, name),
            })
        end
    end

    table.sort(M.items, function(a, b) return a.name < b.name end)
end

--- @return ToolchainItem[]
function M.get_items() return M.items end

--- @param type_name ToolchainType
--- @return string[]
function M.get_enabled(type_name) return M.enabled[type_name] or {} end

--- @param type_name ToolchainType
--- @return string[]
function M.get_extra(type_name) return M.extra[type_name] or {} end

--- @return void
function M.save()
    for type_name, extra in pairs(M.extra) do
        module_loader.save_extra_modules(type_name, extra)
    end
end

return M
