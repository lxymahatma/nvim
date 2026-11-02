local constant = require("config.constant")
local parser = require("toolchain.parser")
local table_helper = require("helpers.table")

---@class ToolchainLoader
---@field items ToolchainItem[]
local M = {
  items = {},
}

--- Get the storage file of a type
---@param type_name ToolchainType
---@return string
local function storage_path(type_name)
  return ("%s/%s.json"):format(constant.storage_dir, type_name)
end

--- Get the enabled non-default specs of a type from storage. A file that isn't valid JSON is ignored with a warning.
---@param type_name ToolchainType
---@return string[]
local function read_extra(type_name)
  local path = storage_path(type_name)
  if vim.fn.filereadable(path) == 0 then return {} end
  local ok, data = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
  if not ok then
    vim.notify(("ignored %s: %s"):format(path, data), vim.log.levels.WARN, { title = "Toolchain" })
    return {}
  end
  return data.extra_modules or {}
end

--- Save the enabled non-default specs of a type to storage
---@param type_name ToolchainType
---@param extra string[]
local function write_extra(type_name, extra)
  local json = vim.json.encode({ extra_modules = extra }, { indent = "  ", sort_keys = true })
  vim.fn.mkdir(constant.storage_dir, "p")
  vim.fn.writefile(vim.split(json, "\n"), storage_path(type_name), "b")
end

--- Get the spec names of a type
---@param type_name ToolchainType
---@return string[]
local function list_modules(type_name)
  local dir = ("%s/lua/toolchain/%s"):format(vim.fn.stdpath("config"), type_name)
  return vim.iter(vim.fs.dir(dir)):map(function(file) return file:sub(1, -5) end):totable()
end

---@param type_name ToolchainType
---@param name string
---@param reason string
local function warn_skipped(type_name, name, reason)
  vim.notify(("skipped %s %s: %s"):format(type_name, name, reason), vim.log.levels.WARN, { title = "Toolchain" })
end

--- Collect the items of every type and load the enabled specs in type order
---@return ToolchainParsedSpec[]
function M.load()
  M.items = {}
  local specs = {}

  for _, toolchain_type in ipairs(constant.toolchain_types) do
    local type_name = toolchain_type.name
    local enabled = table_helper.list_merge(toolchain_type.defaults, read_extra(type_name))

    local items = {}
    for _, name in ipairs(list_modules(type_name)) do
      items[name] = {
        name = name,
        type = type_name,
        module = ("toolchain.%s.%s"):format(type_name, name),
        enabled = vim.list_contains(enabled, name),
        is_default = vim.list_contains(toolchain_type.defaults, name),
      }
      table.insert(M.items, items[name])
    end

    for _, name in ipairs(enabled) do
      local item = items[name]
      if not item then
        warn_skipped(type_name, name, "spec file not found")
      else
        local ok, spec = pcall(require, item.module)
        if ok then
          table.insert(specs, parser.parse(name, spec, type_name))
        else
          warn_skipped(type_name, name, spec)
        end
      end
    end
  end

  table.sort(M.items, function(a, b) return a.name < b.name end)
  return specs
end

--- Get the `exclusive` group of an item, whether enabled or not
---@param item ToolchainItem
---@return string?
local function exclusive_group(item)
  return require(item.module).exclusive
end

--- Get the enabled item that blocks a disabled item by sharing its exclusive group
---@param item ToolchainItem
---@return ToolchainItem?
function M.blocked_by(item)
  local group = not item.enabled and exclusive_group(item)
  if not group then return end
  return vim.iter(M.items):find(function(other) return other.enabled and exclusive_group(other) == group end)
end

--- Toggle an item. A default can't be disabled, and a blocked item can't be enabled.
---@param item ToolchainItem
---@return boolean ok
---@return string message
function M.toggle(item)
  local blocker = M.blocked_by(item)
  if blocker then return false, ("Cannot enable %s while %s is enabled"):format(item.name, blocker.name) end
  if item.is_default then return false, "Cannot disable default: " .. item.name end

  item.enabled = not item.enabled
  return true, ("%s %s. Restart Neovim to apply."):format(item.enabled and "Enabled" or "Disabled", item.name)
end

--- Save the enabled non-default specs of each type
function M.save()
  for _, toolchain_type in ipairs(constant.toolchain_types) do
    local extra = vim.iter(M.items)
      :filter(function(item) return item.type == toolchain_type.name and item.enabled and not item.is_default end)
      :map(function(item) return item.name end)
      :totable()
    write_extra(toolchain_type.name, extra)
  end
end

return M
