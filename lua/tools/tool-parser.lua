local M = {}

---@class ToolFtConfig
---@field lsp string[]
---@field formatters? conform.FiletypeFormatter
---@field linters? string[]

---@class ToolParserCache
---@field configs_by_ft table<string, ToolFtConfig> Tool configurations by filetype
---@field mason_packages MasonPackageSpec[] Mason packages to install
---@field lsp_servers table<string, vim.lsp.ClientConfig> LSP server configurations
---@field extra_plugins LazyPluginSpec[] Extra plugins from tool configs

---@type ToolParserCache
M._cache = {
    configs_by_ft = {},
    mason_packages = {},
    lsp_servers = {},
    extra_plugins = {},
}

---@param server string
---@param local_list string[]
---@param config? table
local function add_lsp(server, local_list, config)
    if config then
        M._cache.lsp_servers[server] = config
    else
        M._cache.lsp_servers[server] = {}
    end
    table.insert(local_list, server)
end

---@param tool_name string
---@param spec ToolSpec
local function parse_spec(tool_name, spec)
    ---@type string[]
    local filetypes = type(spec.filetype) == "table" and spec.filetype or (spec.filetype and { spec.filetype } or {})

    local current_lsps = {}

    if spec.mason then
        if type(spec.mason) == "string" then
            -- mason = "package"
            ---@cast spec.mason string
            table.insert(M._cache.mason_packages, spec.mason)
        elseif type(spec.mason) == "table" then
            ---@cast spec.mason table
            if vim.islist(spec.mason) then
                -- mason = { "package1", "package2" }
                -- mason = { { "package1", ... }, { "package2", ... } }
                vim.list_extend(M._cache.mason_packages, spec.mason)
            elseif spec.mason.condition ~= nil then
                -- mason = { "package", condition = {...} }
                ---@cast spec.mason MasonPackageStruct
                table.insert(M._cache.mason_packages, spec.mason)
            end
        end
    end

    if spec.lsp then
        if type(spec.lsp) == "string" then
            -- lsp = "server"
            ---@cast spec.lsp string
            add_lsp(spec.lsp, current_lsps)
        elseif type(spec.lsp) == "table" then
            ---@cast spec.lsp table
            if vim.islist(spec.lsp) then
                -- lsp = { "server1", "server2" }
                ---@cast spec.lsp string[]
                for _, server in ipairs(spec.lsp) do
                    add_lsp(server, current_lsps)
                end
            else
                -- lsp = { server1 = {...}, server2 = {...} }
                ---@cast spec.lsp table<string, vim.lsp.ClientConfig>
                for server, config in pairs(spec.lsp) do
                    add_lsp(server, current_lsps, config)
                end
            end
        end
    end

    for _, ft in ipairs(filetypes) do
        local cfg = {}

        cfg.lsp = current_lsps

        if spec.formatter then
            if spec.formatter == true then
                -- formatter = true
                cfg.formatters = { tool_name }
            elseif type(spec.formatter) == "string" then
                -- formatter = "tool"
                ---@cast spec.formatter string
                cfg.formatters = { spec.formatter }
            elseif type(spec.formatter) == "table" then
                ---@cast spec.formatter table
                if spec.formatter[ft] then
                    -- formatter = { ft1 = {...}, ft2 = {...} }
                    local fmt = spec.formatter[ft]
                    cfg.formatters = type(fmt) == "string" and { fmt } or fmt
                end
            end
        end

        if spec.linter then
            if spec.linter == true then
                -- linter = true
                cfg.linters = { tool_name }
            elseif type(spec.linter) == "string" then
                -- linter = "tool"
                ---@cast spec.linter string
                cfg.linters = { spec.linter }
            elseif type(spec.linter) == "table" then
                ---@cast spec.linter table
                if spec.linter[ft] then
                    -- linter = { ft1 = {...}, ft2 = {...} }
                    local lint = spec.linter[ft]
                    cfg.linters = type(lint) == "string" and { lint } or lint
                end
            end
        end

        M._cache.configs_by_ft[ft] = cfg
    end

    if spec.plugin then
        if type(spec.plugin) == "string" then
            -- plugin = "user/repo"
            table.insert(M._cache.extra_plugins, spec.plugin)
        elseif type(spec.plugin) == "table" then
            if vim.islist(spec.plugin) then
                -- plugin = { "repo1", "repo2" }
                -- plugin = { { "repo1", ... }, { "repo2", ... } }
                ---@cast spec.plugin LazyPluginSpec[]
                vim.list_extend(M._cache.extra_plugins, spec.plugin)
            else
                -- plugin = { "user/repo", ... }
                ---@cast spec.plugin LazyPluginSpec
                table.insert(M._cache.extra_plugins, spec.plugin)
            end
        end
    end
end

function M.load_all()
    local enabled_tools = require("tools.tool-loader").get_enabled_tools()

    for _, tool in ipairs(enabled_tools) do
        local ok, spec = pcall(require, ("tools.configs.%s"):format(tool))
        if ok and type(spec) == "table" then
            parse_spec(tool, spec)
        else
            vim.notify(("[tool-parser] Failed to load tools.configs.%s"):format(tool), vim.log.levels.WARN)
        end
    end
end

--- Get all mason packages
---@return MasonPackageSpec[]
function M.get_mason_packages() return M._cache.mason_packages end

--- Get all LSP server configurations
---@return table<string, vim.lsp.ClientConfig>
function M.get_lsp_servers() return M._cache.lsp_servers end

---@return table<string, conform.FiletypeFormatter>
function M.get_formatters()
    local result = {}
    for ft, cfg in pairs(M._cache.configs_by_ft) do
        if cfg.formatters then result[ft] = cfg.formatters end
    end
    return result
end

---@return table<string, string[]>
function M.get_linters()
    local result = {}
    for ft, cfg in pairs(M._cache.configs_by_ft) do
        if cfg.linters then result[ft] = cfg.linters end
    end
    return result
end

--- Get all extra plugins
---@return LazyPluginSpec[]
function M.get_extra_plugins() return M._cache.extra_plugins end

--- Get configuration for a specific filetype
---@param filetype string
---@return ToolFtConfig?
function M.get_config_by_ft(filetype) return M._cache.configs_by_ft[filetype] end

return M
