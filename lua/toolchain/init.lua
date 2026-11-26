local loader = require("toolchain.loader")
local table_helper = require("helpers.table")

---@class ToolchainCache
---@field parsers string[] Treesitter parsers to install
---@field mason MasonPackageSpec[] Mason packages to install
---@field servers table<string, vim.lsp.Config> LSP server configurations
---@field formatters table<string, conform.FiletypeFormatterInternal> Conform formatters by filetype
---@field formatter_opts table<string, conform.FormatterConfigOverride> Conform formatter overrides
---@field linters table<string, string[]> nvim-lint linters by filetype
---@field dap_configurations table<string, dap.Configuration[]> nvim-dap configurations by filetype
---@field dap_adapters table<string, dap.Adapter | dap.AdapterFactory> nvim-dap adapters
---@field on_attach table<string, fun(bufnr: integer)[]> `on_attach` functions by filetype
---@field plugins LazyPluginSpec[] Extra plugins
---@field keymaps snacks.Keymap[] Filetype keymaps

---@type ToolchainCache
local cache = {
  parsers = {},
  mason = {},
  servers = {},
  formatters = {},
  formatter_opts = {},
  linters = {},
  dap_configurations = {},
  dap_adapters = {},
  on_attach = {},
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

  for _, ft in ipairs(spec.filetypes) do
    cache.dap_configurations[ft] = table_helper.list_merge(cache.dap_configurations[ft] or {}, spec.dap_configurations)
    cache.on_attach[ft] = table_helper.list_merge(cache.on_attach[ft] or {}, { spec.on_attach })
  end

  -- A later spec's formatters replace an earlier one's
  cache.formatters = vim.tbl_extend("force", cache.formatters, spec.formatters)

  -- Linters of all specs are merged
  for ft, linters in pairs(spec.linters) do
    cache.linters[ft] = table_helper.list_merge(cache.linters[ft] or {}, linters)
  end
end

function M.setup()
  for _, spec in ipairs(loader.load()) do
    add_spec(spec)
  end
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
  return cache.formatters
end

--- Get all conform formatter overrides
---@return table<string, conform.FormatterConfigOverride>
function M.get_formatter_overrides()
  return cache.formatter_opts
end

--- Get linters by filetype
---@return table<string, string[]>
function M.get_linters()
  return cache.linters
end

--- Get DAP configurations by filetype
---@return table<string, dap.Configuration[]>
function M.get_dap_configurations()
  return cache.dap_configurations
end

--- Get all DAP adapters
---@return table<string, dap.Adapter | dap.AdapterFactory>
function M.get_dap_adapters()
  return cache.dap_adapters
end

--- Get `on_attach` functions by filetype
---@return table<string, fun(bufnr: integer)[]>
function M.get_on_attach()
  return cache.on_attach
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
