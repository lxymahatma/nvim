local M = {}

local constant = require("config.constant")
local default_langs = constant.default_langs
local local_config_path = constant.local_config_path

function M.get_all_langs()
    local all_langs = {}
    local lang_files = vim.fn.globpath(constant.lang_dir, "*.lua", false, true)
    for _, file in ipairs(lang_files) do
        local lang = vim.fn.fnamemodify(file, ":t:r")
        table.insert(all_langs, lang)
    end

    return all_langs
end

function M.get_extra_langs()
    if vim.fn.filereadable(local_config_path) == 1 then
        local ok, local_config = pcall(dofile, local_config_path)
        if not ok then return {} end
        return local_config.extra_langs or {}
    end

    return {}
end

function M.get_enabled_langs()
    local extra_langs = M.get_extra_langs()
    local enabled_langs = {}
    vim.list_extend(enabled_langs, default_langs)
    for _, lang in ipairs(extra_langs) do
        if not vim.tbl_contains(enabled_langs, lang) then table.insert(enabled_langs, lang) end
    end
    return enabled_langs
end

function M.save_extra_langs(extra_langs)
    table.sort(extra_langs)
    local content = "return " .. vim.inspect({ extra_langs = extra_langs }) .. "\n"
    local ok = vim.fn.writefile(vim.split(content, "\n"), local_config_path)
    if ok ~= 0 then vim.notify("Failed to write to " .. local_config_path, vim.log.levels.ERROR) end
end

return M
