local M = {}

local STORAGE_KEY = "lang"
local constant = require("config.constant")
local storage_helper = require("helpers.storage")

--- @return string[]
function M.get_all_langs()
    local all_langs = {}
    local lang_files = vim.fn.globpath(constant.lang_dir, "*.lua", false, true)
    for _, file in ipairs(lang_files) do
        local lang = vim.fn.fnamemodify(file, ":t:r")
        table.insert(all_langs, lang)
    end

    return all_langs
end

--- @return string[]
function M.get_extra_langs()
    if storage_helper.exists_json(STORAGE_KEY) then
        local ok, data = pcall(storage_helper.read_json, STORAGE_KEY)
        if not ok then return {} end
        return data.extra_langs or {}
    end

    return {}
end

--- @return string[]
function M.get_enabled_langs()
    local extra_langs = M.get_extra_langs()
    local enabled_langs = {}
    vim.list_extend(enabled_langs, constant.default_langs)
    for _, lang in ipairs(extra_langs) do
        if not vim.tbl_contains(enabled_langs, lang) then table.insert(enabled_langs, lang) end
    end
    return enabled_langs
end

--- @param extra_langs string[]
function M.save_extra_langs(extra_langs)
    table.sort(extra_langs)
    local ok, err = pcall(storage_helper.write_json, STORAGE_KEY, { extra_langs = extra_langs })
    if not ok then vim.notify("Failed to save language config: " .. tostring(err), vim.log.levels.ERROR) end
end

return M
