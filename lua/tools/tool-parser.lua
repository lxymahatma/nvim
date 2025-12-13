local M = {}

---@class ToolParserCache
---@field mason_packages MasonPackageSpec[] Mason packages to install
---@field lsp_servers table<string, vim.lsp.ClientConfig> LSP server configurations
---@field formatters_by_ft table<string, string|string[]> Formatters by filetype
---@field linters_by_ft table<string, string[]> Linters by filetype
---@field extra_plugins LazyPluginSpec[] Extra plugins from tool configs

---@type ToolParserCache
M._cache = {
    mason_packages = {},
    lsp_servers = {},
    formatters_by_ft = {},
    linters_by_ft = {},
    extra_plugins = {},
}

---@param tool_name string
---@param spec ToolSpec
local function parse_spec(tool_name, spec)
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
            M._cache.lsp_servers[spec.lsp] = {}
        elseif type(spec.lsp) == "table" then
            ---@cast spec.lsp table
            if vim.islist(spec.lsp) then
                -- lsp = { "server1", "server2" }
                ---@cast spec.lsp string[]
                for _, server in ipairs(spec.lsp) do
                    M._cache.lsp_servers[server] = {}
                end
            else
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
            -- formatter = "javascript"
            ---@cast spec.formatter string
            M._cache.formatters_by_ft[spec.formatter] = M._cache.formatters_by_ft[spec.formatter] or {}
            table.insert(M._cache.formatters_by_ft[spec.formatter], tool_name)
        elseif type(spec.formatter) == "table" then
            ---@cast spec.formatter table
            if vim.islist(spec.formatter) then
                -- formatter = { "javascript", "typescript" }
                ---@cast spec.formatter string[]
                for _, ft in ipairs(spec.formatter) do
                    M._cache.formatters_by_ft[ft] = M._cache.formatters_by_ft[ft] or {}
                    table.insert(M._cache.formatters_by_ft[ft], tool_name)
                end
            else
                -- formatter = { ft1 = {...}, ft2 = {...} }
                ---@cast spec.formatter table<string, string|string[]>
                for ft, formatters in pairs(spec.formatter) do
                    ---@type string[]
                    local fmt_list = type(formatters) == "table" and formatters or { formatters }
                    M._cache.formatters_by_ft[ft] = fmt_list
                end
            end
        end
    end

    if spec.linter then
        if type(spec.linter) == "string" then
            -- linter = "javascript"
            ---@cast spec.linter string
            M._cache.linters_by_ft[spec.linter] = { tool_name }
        elseif type(spec.linter) == "table" then
            ---@cast spec.linter table
            if vim.islist(spec.linter) then
                -- linter = { "javascript", "typescript" }
                ---@cast spec.linter string[]
                for _, ft in ipairs(spec.linter) do
                    M._cache.linters_by_ft[ft] = { tool_name }
                end
            else
                -- linter = { ft1 = {...}, ft2 = {...} }
                ---@cast spec.linter table<string, string|string[]>
                for ft, linters in pairs(spec.linter) do
                    ---@type string[]
                    local linter_list = type(linters) == "table" and linters or { linters }
                    M._cache.linters_by_ft[ft] = linter_list
                end
            end
        end
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

--- Get all formatter configurations
---@return table<string, string|string[]>
function M.get_formatters() return M._cache.formatters_by_ft end

--- Get all linter configurations
---@return table<string, string[]>
function M.get_linters() return M._cache.linters_by_ft end

--- Get all extra plugins
---@return LazyPluginSpec[]
function M.get_extra_plugins() return M._cache.extra_plugins end

return M
