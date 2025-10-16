local M = {}

local enabled_languages = {
    "git",
    "json",
    "lua",
    "markdown",
    "nushell",
    "toml",
    "xml",
    "yaml",
}

function M.get_enabled_languages()
    local ok, local_config = pcall(require, "config.local")
    if not ok then return enabled_languages end

    for _, lang in local_config.extra_languages do
        table.insert(enabled_languages, lang)
    end

    return enabled_languages
end

function M.is_enabled(lang_name)
    local enabled_langs = M.get_enabled_languages()

    if not enabled_langs then return false end

    for _, lang in ipairs(enabled_langs) do
        if lang == lang_name then return true end
    end

    return false
end

return M
