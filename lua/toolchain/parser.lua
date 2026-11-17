local M = {}

---@class ToolchainParsedSpec
---@field filetypes string[]
---@field parsers string[]
---@field mason MasonPackageSpec[]
---@field servers table<string, vim.lsp.Config>
---@field formatters table<string, conform.FiletypeFormatterInternal>
---@field formatter_opts table<string, conform.FormatterConfigOverride>
---@field linters table<string, string[]>
---@field dap_configurations dap.Configuration[]
---@field dap_adapters table<string, dap.Adapter | dap.AdapterFactory>
---@field plugins LazyPluginSpec[]
---@field keymaps snacks.Keymap[]
---@field on_attach? fun(bufnr: integer)

--- Get the filetypes
---@param value any
---@param name string
---@param type_name ToolchainType
---@return string[]
local function parse_filetype(value, name, type_name)
  if type(value) == "string" then
    -- filetype = "ft"
    return { value }
  elseif not value and type_name == "lang" then
    -- a lang's filetype defaults to the spec name
    return { name }
  end
  -- filetype = { "ft1", "ft2" }
  return value or {}
end

--- Get the treesitter parsers
---@param value any
---@param name string
---@return string[]
local function parse_treesitter(value, name)
  if value == true then
    -- treesitter = true
    return { name }
  elseif type(value) == "string" then
    -- treesitter = "parser"
    return { value }
  end
  -- treesitter = { "parser1", "parser2" }
  return value or {}
end

--- Get the mason packages
---@param value any
---@return MasonPackageSpec[]
local function parse_mason(value)
  if type(value) == "string" then
    -- mason = "package"
    return { value }
  elseif value and not vim.islist(value) then
    -- mason = { "package", condition = {...} }
    return { value }
  end
  -- mason = { "package1", { "package2", condition = {...} } }
  return value or {}
end

--- Get the LSP server configs
---@param value any
---@return table<string, vim.lsp.Config>
local function parse_lsp(value)
  if type(value) == "string" then
    -- lsp = "server"
    return { [value] = {} }
  end
  local servers = {}
  for key, item in pairs(value or {}) do
    if type(key) == "number" then
      -- lsp = { "server1", "server2" }
      servers[item] = {}
    else
      -- lsp = { server1 = {...}, server2 = {...} }
      servers[key] = item
    end
  end
  return servers
end

--- Get the formatters of each filetype
---@param value any
---@param filetypes string[]
---@param name string
---@return table<string, conform.FiletypeFormatterInternal>
local function parse_formatter(value, filetypes, name)
  local formatters = {}
  for _, ft in ipairs(filetypes) do
    if value == true then
      -- formatter = true
      formatters[ft] = { name }
    elseif type(value) == "string" then
      -- formatter = "tool"
      formatters[ft] = { value }
    elseif type(value) == "table" then
      if value[1] ~= nil then
        -- formatter = { "tool1", "tool2" }
        -- formatter = { "tool1", lsp_format = "last" }
        formatters[ft] = value
      elseif type(value[ft]) == "string" then
        -- formatter = { ft1 = "tool1" }
        formatters[ft] = { value[ft] }
      else
        -- formatter = { ft1 = { "tool1", lsp_format = "last" } }
        formatters[ft] = value[ft]
      end
    end
  end
  return formatters
end

--- Get the linters of each filetype
---@param value any
---@param filetypes string[]
---@return table<string, string[]>
local function parse_linter(value, filetypes)
  local linters = {}
  for _, ft in ipairs(filetypes) do
    if type(value) == "string" then
      -- linter = "tool"
      linters[ft] = { value }
    elseif type(value) == "table" then
      if value[1] ~= nil then
        -- linter = { "tool1", "tool2" }
        linters[ft] = value
      elseif type(value[ft]) == "string" then
        -- linter = { ft1 = "tool1" }
        linters[ft] = { value[ft] }
      else
        -- linter = { ft1 = { "tool1", "tool2" } }
        linters[ft] = value[ft]
      end
    end
  end
  return linters
end

--- Get the extra plugins
---@param value any
---@return table
local function parse_plugin(value)
  if type(value) == "string" then
    -- plugin = "user/repo"
    return { value }
  elseif value and not vim.islist(value) then
    -- plugin = { "user/repo", ... }
    return { value }
  end
  -- plugin = { { "user/repo1", ... }, { "user/repo2", ... } }
  return value or {}
end

--- Parse a spec
---@param name string
---@param spec ToolchainSpec
---@param type_name ToolchainType
---@return ToolchainParsedSpec
function M.parse(name, spec, type_name)
  local filetypes = parse_filetype(spec.filetype, name, type_name)

  ---@type ToolchainParsedSpec
  return {
    filetypes = filetypes,
    parsers = parse_treesitter(spec.treesitter, name),
    mason = parse_mason(spec.mason),
    servers = parse_lsp(spec.lsp),
    formatters = parse_formatter(spec.formatter, filetypes, name),
    formatter_opts = spec.formatter_opts or {},
    linters = parse_linter(spec.linter, filetypes),
    dap_configurations = spec.dap_configurations or {},
    dap_adapters = spec.dap_adapters or {},
    plugins = parse_plugin(spec.plugin),
    keymaps = spec.keymaps or {},
    on_attach = spec.on_attach,
  }
end

return M
