local M = {}

M._cache = {
    treesitter_parsers = {}, -- string[]
    mason_packages = {},     -- MasonPackageSpec[]
    lsp_servers = {},        -- table<string, vim.lsp.ClientConfig>
    formatters_by_ft = {},   -- table<string, string[]>
    linters_by_ft = {},      -- table<string, string[]>
    dap_configs = {},        -- table
    extra_plugins = {},      -- LazyPluginSpec[]
}

---@param lang_name string
---@param spec LanguageSpec
local function parse_spec(lang_name, spec)
    if spec.treesitter then
        local parsers = type(spec.treesitter) == "table" and spec.treesitter or { spec.treesitter }
        for _, parser in ipairs(parsers) do
            if not vim.tbl_contains(M._cache.treesitter_parsers, parser) then table.insert(M._cache.treesitter_parsers, parser) end
        end
    end

    if spec.mason then
        local packages = type(spec.mason) == "table" and spec.mason or { spec.mason }
        if type(packages[1]) == "string" or (type(packages[1]) == "table" and packages[1][1]) then
            vim.list_extend(M._cache.mason_packages, packages)
        else
            table.insert(M._cache.mason_packages, spec.mason)
        end
    end

    if spec.lsp then
        if type(spec.lsp) == "string" then
            M._cache.lsp_servers[spec.lsp] = {}
        elseif type(spec.lsp) == "table" then
            if spec.lsp[1] and type(spec.lsp[1]) == "string" then
                for _, server in ipairs(spec.lsp) do
                    M._cache.lsp_servers[server] = {}
                end
            else
                for server, config in pairs(spec.lsp) do
                    M._cache.lsp_servers[server] = config
                end
            end
        end
    end

    if spec.formatter then
        if type(spec.formatter) == "string" then
            M._cache.formatters_by_ft[lang_name] = { spec.formatter }
        else
            for ft, formatters in pairs(spec.formatter) do
                local fmt_list = type(formatters) == "table" and formatters or { formatters }
                M._cache.formatters_by_ft[ft] = fmt_list
            end
        end
    end

    -- 处理 linter
    if spec.linter then
        if type(spec.linter) == "string" then
            M._cache.linters_by_ft[lang_name] = { spec.linter }
        else
            for ft, linters in pairs(spec.linter) do
                local linter_list = type(linters) == "table" and linters or { linters }
                M._cache.linters_by_ft[ft] = linter_list
            end
        end
    end

    if spec.dap then vim.tbl_deep_extend("force", M._cache.dap_configs, spec.dap) end

    if spec.plugins then
        local plugins = type(spec.plugins) == "table" and spec.plugins or { spec.plugins }
        if plugins[1] and type(plugins[1]) == "table" then
            vim.list_extend(M._cache.extra_plugins, plugins)
        else
            table.insert(M._cache.extra_plugins, spec.plugins)
        end
    end
end

function M.load_all()
    local enabled_langs = require("helpers.lang-loader").get_enabled_langs()

    for _, lang in ipairs(enabled_langs) do
        local ok, spec = pcall(require, ("config.lang.%s"):format(lang))
        if ok and type(spec) == "table" then
            parse_spec(lang, spec)
        else
            vim.notify(string.format("[lang-parser] Failed to load config.lang.%s", lang), vim.log.levels.WARN)
        end
    end
end

--- Get all treesitter parsers
---@return string[]
function M.get_treesitter_parsers() return M._cache.treesitter_parsers end

--- Get all mason packages
---@return MasonPackageSpec[]
function M.get_mason_packages() return M._cache.mason_packages end

--- Get all LSP server configurations
---@return table<string, vim.lsp.ClientConfig>
function M.get_lsp_servers() return M._cache.lsp_servers end

--- Get all formatter configurations
---@return table<string, string[]>
function M.get_formatters() return M._cache.formatters_by_ft end

--- Get all linter configurations
---@return table<string, string[]>
function M.get_linters() return M._cache.linters_by_ft end

--- Get all DAP configurations
---@return table
function M.get_dap_configs() return M._cache.dap_configs end

--- Get all extra plugins
---@return LazyPluginSpec[]
function M.get_extra_plugins() return M._cache.extra_plugins end

return M
