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
            -- formatter = "javascript"
            M._cache.formatters_by_ft[spec.formatter] = { tool_name }
        elseif type(spec.formatter) == "table" then
            if type(spec.formatter[1]) == "string" then
                -- formatter = { "javascript", "typescript" }
                ---@cast spec.formatter string[]
                for _, ft in ipairs(spec.formatter) do
                    M._cache.formatters_by_ft[ft] = { tool_name }
                end
            elseif spec.formatter[1] == nil then
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
            M._cache.linters_by_ft[spec.linter] = { tool_name }
        elseif type(spec.linter) == "table" then
            if type(spec.linter[1]) == "string" then
                -- linter = { "javascript", "typescript" }
                ---@cast spec.linter string[]
                for _, ft in ipairs(spec.linter) do
                    M._cache.linters_by_ft[ft] = { tool_name }
                end
            elseif spec.linter[1] == nil then
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

    if spec.plugins then
        if type(spec.plugins) == "string" then
            -- plugins = "user/repo"
            table.insert(M._cache.extra_plugins, spec.plugins)
        elseif type(spec.plugins) == "table" then
            if type(spec.plugins[1]) == "table" then
                -- plugins = { { "repo1", ... }, { "repo2", ... } }
                ---@cast spec.plugins LazyPluginSpec[]
                vim.list_extend(M._cache.extra_plugins, spec.plugins)
            elseif type(spec.plugins[1]) == "string" then
                if type(spec.plugins[2]) == "string" then
                    -- plugins = { "repo1", "repo2", ... }
                    ---@cast spec.plugins string[]
                    vim.list_extend(M._cache.extra_plugins, spec.plugins)
                else
                    -- plugins = { "repo", config = ... }
                    ---@cast spec.plugins LazyPluginSpec
                    table.insert(M._cache.extra_plugins, spec.plugins)
                end
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
            vim.notify(string.format("[tool-parser] Failed to load tools.configs.%s", tool), vim.log.levels.WARN)
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
