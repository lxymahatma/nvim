local loader = require("toolchain.loader")
local table_helper = require("helpers.table")

---@class ToolchainFtConfig
---@field treesitter string[]
---@field lsp string[]
---@field formatters? conform.FiletypeFormatterInternal
---@field linters? string[]
---@field dap_configurations dap.Configuration[]
---@field on_attach fun(bufnr: integer)[]

---@class ToolchainCache
---@field configs_by_ft table<string, ToolchainFtConfig> Configurations by filetype
---@field parsers string[] Treesitter parsers to install
---@field mason MasonPackageSpec[] Mason packages to install
---@field servers table<string, vim.lsp.Config> LSP server configurations
---@field formatter_opts table<string, conform.FormatterConfigOverride> Conform formatter overrides
---@field dap_adapters table<string, dap.Adapter | dap.AdapterFactory> nvim-dap adapters
---@field plugins LazyPluginSpec[] Extra plugins
---@field keymaps snacks.Keymap[]

---@type ToolchainCache
local cache = {
  configs_by_ft = {},
  parsers = {},
  mason = {},
  servers = {},
  formatter_opts = {},
  dap_adapters = {},
  plugins = {},
  keymaps = {},
}

local M = {}

---@param spec ToolchainParsedSpec
local function add_spec(spec)
  vim.list_extend(cache.parsers, spec.parsers)
  vim.list_extend(cache.mason, spec.mason)
  vim.list_extend(cache.plugins, spec.plugins)
  cache.formatter_opts = vim.tbl_deep_extend("force", cache.formatter_opts, spec.formatter_opts)
  cache.dap_adapters = vim.tbl_extend("force", cache.dap_adapters, spec.dap_adapters)

  for server, config in pairs(spec.servers) do
    cache.servers[server] = vim.tbl_deep_extend("force", cache.servers[server] or {}, config)
  end

  for _, km in ipairs(spec.keymaps) do
    local opts = vim.tbl_extend("keep", km.opts or {}, { ft = spec.filetypes })
    table.insert(cache.keymaps, { mode = km.mode, lhs = km.lhs, rhs = km.rhs, opts = opts })
  end

  local servers = vim.tbl_keys(spec.servers)
  table.sort(servers)
  for _, ft in ipairs(spec.filetypes) do
    cache.configs_by_ft[ft] = cache.configs_by_ft[ft]
      or {
        treesitter = {},
        lsp = {},
        dap_configurations = {},
        on_attach = {},
      }
    local config = cache.configs_by_ft[ft]
    vim.list_extend(config.treesitter, spec.parsers)
    vim.list_extend(config.lsp, servers)
    vim.list_extend(config.dap_configurations, spec.dap_configurations)
    if spec.on_attach then table.insert(config.on_attach, spec.on_attach) end
  end

  -- A later spec's formatters replace an earlier one's
  for ft, formatters in pairs(spec.formatters) do
    cache.configs_by_ft[ft].formatters = formatters
  end

  -- Linters of all specs are merged
  for ft, linters in pairs(spec.linters) do
    local config = cache.configs_by_ft[ft]
    config.linters = table_helper.list_merge(config.linters or {}, linters)
  end
end

function M.setup()
  for _, spec in ipairs(loader.load()) do
    add_spec(spec)
  end
end

--- Get configuration for a specific filetype
---@param ft string
---@return ToolchainFtConfig?
function M.get_config_by_ft(ft)
  return cache.configs_by_ft[ft]
end

--- Get all treesitter parsers
---@return string[]
function M.get_treesitter_parsers()
  return cache.parsers
end

--- Get all mason packages
---@return MasonPackageSpec[]
function M.get_mason_packages()
  return cache.mason
end

--- Get all LSP server configurations
---@return table<string, vim.lsp.Config>
function M.get_lsp_servers()
  return cache.servers
end

--- Get formatters by filetype
---@return table<string, conform.FiletypeFormatterInternal>
function M.get_formatters()
  return vim.tbl_map(function(config) return config.formatters end, cache.configs_by_ft)
end

--- Get all conform formatter overrides
---@return table<string, conform.FormatterConfigOverride>
function M.get_formatter_overrides()
  return cache.formatter_opts
end

--- Get linters by filetype
---@return table<string, string[]>
function M.get_linters()
  return vim.tbl_map(function(config) return config.linters end, cache.configs_by_ft)
end

--- Get DAP configurations by filetype
---@return table<string, dap.Configuration[]>
function M.get_dap_configurations()
  return vim.tbl_map(function(config) return config.dap_configurations end, cache.configs_by_ft)
end

--- Get all DAP adapters
---@return table<string, dap.Adapter | dap.AdapterFactory>
function M.get_dap_adapters()
  return cache.dap_adapters
end

--- Get all extra plugins
---@return LazyPluginSpec[]
function M.get_extra_plugins()
  return cache.plugins
end

--- Get all keymaps
---@return snacks.Keymap[]
function M.get_keymaps()
  return cache.keymaps
end

return M
