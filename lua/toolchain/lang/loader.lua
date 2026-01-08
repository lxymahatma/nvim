local constant = require("config.constant")
local module_loader = require("helpers.module-loader")

local M = {}

local STORAGE_KEY = "lang"

--- @return string[]
function M.get_all_langs() return module_loader.get_all_modules(constant.lang_dir) end

--- @return string[]
function M.get_extra_langs() return module_loader.get_extra_modules(STORAGE_KEY) end

--- @return string[]
function M.get_enabled_langs() return module_loader.get_enabled_modules(constant.default_langs, STORAGE_KEY) end

--- @param extra_langs string[]
function M.save_extra_langs(extra_langs) module_loader.save_extra_modules(STORAGE_KEY, extra_langs) end

return M
