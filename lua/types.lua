---@meta

-- Mason Package Specification
---@class ConditionOptions
---@field missing? string|boolean If string, checks that specific executable. If true, use the package name as executable name.

---@alias ConditionSpec fun(): boolean | ConditionOptions
---@alias MasonPackageSpec string | { [1]: string, condition?: ConditionSpec }

-- Language configuration specification
---@class LanguageSpec
---@field treesitter? string|string[] Treesitter parsers to install. Can be a single parser name or a list of parser names.
---@field mason? MasonPackageSpec|MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
---@field lsp? string | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
---@field formatter? string | table<string, string|string[]> Formatters by filetype. Can be a single formatter name or (filetype -> formatters) map.
---@field linter? string | table<string, string|string[]> Linters by filetype. Can be a single linter name or (filetype -> linters) map.
---@field dap? table DAP (Debug Adapter Protocol) configuration
---@field plugins? LazyPluginSpec | LazyPluginSpec[] Plugins to install. Can be a single plugin spec or a list of plugin specs.
