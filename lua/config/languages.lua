local constant = require("config.constant")
local lang_loader = require("helpers.lang-loader")
local default_langs = constant.default_langs

local function get_available_langs_for_enable()
    local all_langs = lang_loader.get_all_langs()
    local enabled_langs = lang_loader.get_enabled_langs()

    local available_langs = {}
    for _, lang in ipairs(all_langs) do
        if not vim.tbl_contains(enabled_langs, lang) then table.insert(available_langs, lang) end
    end
    return available_langs
end

local function get_available_langs_for_disable() return lang_loader.get_extra_langs() end

vim.api.nvim_create_user_command("LangEnable", function(opts)
    local langs_to_add = opts.fargs
    if #langs_to_add == 0 then
        vim.notify("LangEnable: No languages specified. Usage: :LangEnable <lang1> <lang2> ...", vim.log.levels.ERROR)
        return
    end

    local extra_langs = lang_loader.get_extra_langs()

    for _, lang in ipairs(langs_to_add) do
        if vim.tbl_contains(default_langs, lang) then
            vim.notify(string.format("LangEnable: Language '%s' is enabled by default.", lang), vim.log.levels.WARN)
        elseif vim.tbl_contains(extra_langs, lang) then
            vim.notify(string.format("LangEnable: Language '%s' is already enabled.", lang), vim.log.levels.WARN)
        else
            table.insert(extra_langs, lang)
        end
    end

    lang_loader.save_extra_langs(extra_langs)

    vim.notify(
        string.format(
            "LangEnable: Added languages: %s. Restart Neovim to apply changes.",
            table.concat(langs_to_add, ", ")
        ),
        vim.log.levels.INFO
    )
end, {
    nargs = "+",
    complete = get_available_langs_for_enable,
    desc = "Enable language support",
})

vim.api.nvim_create_user_command("LangDisable", function(opts)
    local langs_to_remove = opts.fargs
    if #langs_to_remove == 0 then
        vim.notify("LangDisable: No languages specified. Usage: :LangDisable <lang1> <lang2> ...", vim.log.levels.ERROR)
        return
    end

    local extra_langs = lang_loader.get_extra_langs()
    if #extra_langs == 0 then
        vim.notify("LangDisable: No local configuration found. No languages to disable.", vim.log.levels.WARN)
        return
    end

    local removed_langs = {}

    for _, lang in ipairs(langs_to_remove) do
        if vim.tbl_contains(default_langs, lang) then
            vim.notify(("LangDisable: '%s' cannot be disabled."):format(lang), vim.log.levels.WARN)
        elseif vim.tbl_contains(extra_langs, lang) then
            extra_langs = vim.tbl_filter(function(v) return v ~= lang end, extra_langs)
            table.insert(removed_langs, lang)
        else
            vim.notify(("LangDisable: '%s' is not enabled."):format(lang), vim.log.levels.WARN)
        end
    end

    lang_loader.save_extra_langs(extra_langs)

    vim.notify(
        string.format(
            "LangDisable: Removed languages: %s. Restart Neovim to apply changes.",
            table.concat(removed_langs, ", ")
        ),
        vim.log.levels.INFO
    )
end, {
    nargs = "+",
    complete = get_available_langs_for_disable,
    desc = "Disable language support",
})
