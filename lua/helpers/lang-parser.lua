local M = {}

---@class LangParserCache
---@field treesitter_parsers string[] Treesitter parsers to install
---@field mason_packages MasonPackageSpec[] Mason packages to install
---@field lsp_servers table<string, vim.lsp.ClientConfig> LSP server configurations
---@field formatters_by_ft table<string, string|string[]> Formatters by filetype
---@field linters_by_ft table<string, string[]> Linters by filetype
---@field dap_configs table DAP configurations
---@field extra_plugins LazyPluginSpec[] Extra plugins from language configs

---@type LangParserCache
M._cache = {
    treesitter_parsers = {},
    mason_packages = {},
    lsp_servers = {},
    formatters_by_ft = {},
    linters_by_ft = {},
    dap_configs = {},
    extra_plugins = {},
}

---@param lang_name string
---@param spec LanguageSpec
local function parse_spec(lang_name, spec)
    if spec.treesitter then
        ---@param parser string
        local function add_parser(parser)
            if not vim.tbl_contains(M._cache.treesitter_parsers, parser) then table.insert(M._cache.treesitter_parsers, parser) end
        end

        if type(spec.treesitter) == "boolean" then
            -- treesitter = true
            ---@cast spec.treesitter boolean
            if spec.treesitter then add_parser(lang_name) end
        elseif type(spec.treesitter) == "table" then
            -- treesitter = { "parser1", "parser2" }
            ---@cast spec.treesitter string[]
            for _, parser in ipairs(spec.treesitter) do
                add_parser(parser)
            end
        else
            -- treesitter = "parser"
            ---@cast spec.treesitter string
            add_parser(spec.treesitter)
        end
    end

    if spec.mason then
        if type(spec.mason) == "string" then
            -- mason = "package"
            ---@cast spec.mason string
            table.insert(M._cache.mason_packages, spec.mason)
        elseif type(spec.mason) == "table" then
            if type(spec.mason[1]) == "string" then
                if type(spec.mason[2]) == "string" then
                    -- mason = { "package1", "package2" }
                    ---@cast spec.mason string[]
                    vim.list_extend(M._cache.mason_packages, spec.mason)
                elseif spec.mason.condition ~= nil then
                    -- mason = { "package", condition = {...} }
                    ---@cast spec.mason MasonPackageStruct
                    table.insert(M._cache.mason_packages, spec.mason)
                end
            elseif type(spec.mason[1]) == "table" then
                -- mason = { { "package1", ... }, { "package2", ... } }
                ---@cast spec.mason MasonPackageSpec[]
                vim.list_extend(M._cache.mason_packages, spec.mason)
            end
        end
    end

    if spec.lsp then
        if type(spec.lsp) == "string" then
            -- lsp = "server"
            ---@cast spec.lsp string
            M._cache.lsp_servers[spec.lsp] = {}
        elseif type(spec.lsp) == "table" then
            if type(spec.lsp[1]) == "string" then
                -- lsp = { "server1", "server2" }
                ---@cast spec.lsp string[]
                for _, server in ipairs(spec.lsp) do
                    M._cache.lsp_servers[server] = {}
                end
            elseif spec.lsp[1] == nil then
                -- lsp = { server1 = {...}, server2 = {...} }
                ---@cast spec.lsp table<string, vim.lsp.ClientConfig>
                for server, config in pairs(spec.lsp) do
                    M._cache.lsp_servers[server] = config
                end
            end
        end
    end

    if spec.formatter then
        if type(spec.formatter) == "string" then
            -- formatter = "tool"
            M._cache.formatters_by_ft[lang_name] = { spec.formatter }
        elseif type(spec.formatter) == "table" then
            if type(spec.formatter[1]) == "string" then
                -- formatter = { "tool1", "tool2" }
                ---@cast spec.formatter string[]
                M._cache.formatters_by_ft[lang_name] = spec.formatter
            elseif spec.formatter[1] == nil then
                -- formatter = { ft1 = {...}, ft2 = {...} }
                ---@cast spec.formatter table<string, string|string[]>
                for ft, formatters in pairs(spec.formatter) do
                    local fmt_list = type(formatters) == "table" and formatters or { formatters }
                    M._cache.formatters_by_ft[ft] = fmt_list
                end
            end
        end
    end

    if spec.linter then
        if type(spec.linter) == "string" then
            -- linter = "tool"
            M._cache.linters_by_ft[lang_name] = { spec.linter }
        elseif type(spec.linter) == "table" then
            if type(spec.linter[1]) == "string" then
                -- linter = { "tool1", "tool2" }
                ---@cast spec.linter string[]
                M._cache.linters_by_ft[lang_name] = spec.linter
            elseif spec.linter[1] == nil then
                -- linter = { ft1 = {...}, ft2 = {...} }
                ---@cast spec.linter table<string, string|string[]>
                for ft, linters in pairs(spec.linter) do
                    local linter_list = type(linters) == "table" and linters or { linters }
                    M._cache.linters_by_ft[ft] = linter_list
                end
            end
        end
    end

    if spec.dap then vim.tbl_deep_extend("force", M._cache.dap_configs, spec.dap) end

    if spec.plugins then
        if type(spec.plugins) == "string" then
            -- plugins = "user/repo"
            table.insert(M._cache.extra_plugins, spec.plugins)
        elseif type(spec.plugins) == "table" then
            -- plugins = { "repo1", "repo2" }
            -- plugins = { { "repo1", ... }, { "repo2", ... } }
            ---@cast spec.plugins LazyPluginSpec[]
            vim.list_extend(M._cache.extra_plugins, spec.plugins)
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
---@return table<string, string|string[]>
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
