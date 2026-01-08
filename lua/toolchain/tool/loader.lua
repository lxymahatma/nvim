local constant = require("config.constant")
local module_loader = require("helpers.module-loader")

local M = {}

local STORAGE_KEY = "tool"

--- @return string[]
function M.get_all_tools() return module_loader.get_all_modules(constant.tool_dir) end

--- @return string[]
function M.get_extra_tools() return module_loader.get_extra_modules(STORAGE_KEY) end

--- @return string[]
function M.get_enabled_tools() return module_loader.get_enabled_modules(constant.default_tools, STORAGE_KEY) end

--- @param extra_tools string[]
function M.save_extra_tools(extra_tools) module_loader.save_extra_modules(STORAGE_KEY, extra_tools) end

return M
