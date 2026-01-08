local M = {}

--- @class LangFtConfig
--- @field treesitter string[]
--- @field lsp string[]
--- @field formatters? conform.FiletypeFormatter
--- @field linters? string[]
--- @field on_attach? fun(bufnr: integer)

--- @class LangParserCache
--- @field configs_by_ft table<string, LangFtConfig> Language configurations by filetype
--- @field treesitter_parsers string[] Treesitter parsers to install
--- @field mason_packages MasonPackageSpec[] Mason packages to install
--- @field lsp_servers table<string, vim.lsp.ClientConfig> LSP server configurations
--- @field dap_configs table DAP configurations
--- @field extra_plugins LazyPluginSpec[] Extra plugins from language configs

--- @type LangParserCache
M._cache = {
    configs_by_ft = {},
    treesitter_parsers = {},
    mason_packages = {},
    lsp_servers = {},
    dap_configs = {},
    extra_plugins = {},
}

--- @param parser string
--- @param local_list string[]
local function add_parser(parser, local_list)
    table.insert(M._cache.treesitter_parsers, parser)
    table.insert(local_list, parser)
end

--- @param server string
--- @param local_list string[]
--- @param config? table
local function add_lsp(server, local_list, config)
    if config then
        M._cache.lsp_servers[server] = config
    else
        M._cache.lsp_servers[server] = {}
    end
    table.insert(local_list, server)
end

--- @param lang_name string
--- @param spec LanguageSpec
local function parse_spec(lang_name, spec)
    --- @type string[]
    local filetypes = type(spec.filetype) == "table" and spec.filetype or { spec.filetype or lang_name }

    local current_parsers = {}
    local current_lsps = {}

    if type(spec.treesitter) == "boolean" then
        -- treesitter = true
        --- @cast spec.treesitter boolean
        add_parser(lang_name, current_parsers)
    elseif type(spec.treesitter) == "string" then
        -- treesitter = "parser"
        --- @cast spec.treesitter string
        add_parser(spec.treesitter, current_parsers)
    elseif type(spec.treesitter) == "table" then
        -- treesitter = { "parser1", "parser2" }
        --- @cast spec.treesitter string[]
        for _, parser in ipairs(spec.treesitter) do
            add_parser(parser, current_parsers)
        end
    end

    if spec.mason then
        if type(spec.mason) == "string" then
            -- mason = "package"
            --- @cast spec.mason string
            table.insert(M._cache.mason_packages, spec.mason)
        elseif type(spec.mason) == "table" then
            if type(spec.mason[1]) == "string" then
                if type(spec.mason[2]) == "string" then
                    -- mason = { "package1", "package2" }
                    --- @cast spec.mason string[]
                    vim.list_extend(M._cache.mason_packages, spec.mason)
                elseif spec.mason.condition ~= nil then
                    -- mason = { "package", condition = {...} }
                    --- @cast spec.mason MasonPackageStruct
                    table.insert(M._cache.mason_packages, spec.mason)
                end
            elseif type(spec.mason[1]) == "table" then
                -- mason = { { "package1", ... }, { "package2", ... } }
                --- @cast spec.mason MasonPackageSpec[]
                vim.list_extend(M._cache.mason_packages, spec.mason)
            end
        end
    end

    if spec.lsp then
        if type(spec.lsp) == "string" then
            -- lsp = "server"
            --- @cast spec.lsp string
            add_lsp(spec.lsp, current_lsps)
        elseif type(spec.lsp) == "table" then
            if type(spec.lsp[1]) == "string" then
                -- lsp = { "server1", "server2" }
                --- @cast spec.lsp string[]
                for _, server in ipairs(spec.lsp) do
                    add_lsp(server, current_lsps)
                end
            elseif spec.lsp[1] == nil then
                -- lsp = { server1 = {...}, server2 = {...} }
                --- @cast spec.lsp table<string, vim.lsp.ClientConfig>
                for server, config in pairs(spec.lsp) do
                    add_lsp(server, current_lsps, config)
                end
            end
        end
    end

    for _, ft in ipairs(filetypes) do
        local cfg = {}

        cfg.treesitter = current_parsers
        cfg.lsp = current_lsps

        if spec.formatter then
            if type(spec.formatter) == "string" then
                -- formatter = "tool"
                --- @cast spec.formatter string
                cfg.formatters = { spec.formatter }
            elseif type(spec.formatter) == "table" then
                --- @cast spec.formatter table
                if spec.formatter[1] ~= nil then
                    -- formatter = { "tool1", "tool2", ... }
                    -- formatter = { "tool1", lsp_format = "last", ... }
                    cfg.formatters = spec.formatter
                elseif spec.formatter[ft] then
                    -- formatter = { ft1 = {...}, ft2 = {...} }
                    local fmt = spec.formatter[ft]
                    cfg.formatters = type(fmt) == "string" and { fmt } or fmt
                end
            end
        end

        if spec.linter then
            if type(spec.linter) == "string" then
                -- linter = "tool"
                --- @cast spec.linter string
                cfg.linters = { spec.linter }
            elseif type(spec.linter) == "table" then
                --- @cast spec.linter table
                if vim.islist(spec.linter) then
                    -- linter = { "tool1", "tool2" }
                    --- @cast spec.linter string[]
                    cfg.linters = spec.linter
                elseif spec.linter[ft] then
                    -- linter = { ft1 = {...}, ft2 = {...} }
                    local lint = spec.linter[ft]
                    cfg.linters = type(lint) == "string" and { lint } or lint
                end
            end
        end

        if spec.on_attach then cfg.on_attach = spec.on_attach end

        M._cache.configs_by_ft[ft] = cfg
    end

    if spec.dap then M._cache.dap_configs = vim.tbl_deep_extend("force", M._cache.dap_configs, spec.dap) end

    if spec.plugin then
        if type(spec.plugin) == "string" then
            -- plugin = "user/repo"
            table.insert(M._cache.extra_plugins, spec.plugin)
        elseif type(spec.plugin) == "table" then
            if vim.islist(spec.plugin) then
                -- plugin = { "repo1", "repo2" }
                -- plugin = { { "repo1", ... }, { "repo2", ... } }
                --- @cast spec.plugin LazyPluginSpec[]
                vim.list_extend(M._cache.extra_plugins, spec.plugin)
            else
                -- plugin = { "user/repo", ... }
                --- @cast spec.plugin LazyPluginSpec
                table.insert(M._cache.extra_plugins, spec.plugin)
            end
        end
    end
end

function M.load_all()
    local enabled_langs = require("toolchain.lang.loader").get_enabled_langs()

    for _, lang in ipairs(enabled_langs) do
        local ok, spec = pcall(require, ("toolchain.lang.configs.%s"):format(lang))
        if ok and type(spec) == "table" then
            parse_spec(lang, spec)
        else
            vim.notify(string.format("[lang-parser] Failed to load toolchain.lang.configs.%s", lang), vim.log.levels.WARN)
        end
    end
end

--- Get all treesitter parsers
--- @return string[]
function M.get_treesitter_parsers() return M._cache.treesitter_parsers end

--- Get all configured filetypes
--- @return string[]
function M.get_filetypes() return vim.tbl_keys(M._cache.configs_by_ft) end

--- Get all mason packages
--- @return MasonPackageSpec[]
function M.get_mason_packages() return M._cache.mason_packages end

--- Get all LSP server configurations
--- @return table<string, vim.lsp.ClientConfig>
function M.get_lsp_servers() return M._cache.lsp_servers end

--- @return table<string, conform.FiletypeFormatter>
function M.get_formatters()
    local result = {}
    for ft, cfg in pairs(M._cache.configs_by_ft) do
        if cfg.formatters then result[ft] = cfg.formatters end
    end
    return result
end

--- @return table<string, string[]>
function M.get_linters()
    local result = {}
    for ft, cfg in pairs(M._cache.configs_by_ft) do
        if cfg.linters then result[ft] = cfg.linters end
    end
    return result
end

--- Get all DAP configurations
--- @return table
function M.get_dap_configs() return M._cache.dap_configs end

--- Get all extra plugins
--- @return LazyPluginSpec[]
function M.get_extra_plugins() return M._cache.extra_plugins end

--- Get configuration for a specific filetype
--- @param filetype string
--- @return LangFtConfig?
function M.get_config_by_ft(filetype) return M._cache.configs_by_ft[filetype] end

return M
