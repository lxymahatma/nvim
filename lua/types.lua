---@meta

-- Mason Package Specification
---@class ConditionOptions
---@field missing? string|boolean If string, checks that specific executable. If true, use the package name as executable name.

---@class MasonPackageStruct
---@field [1] string Package name
---@field condition? ConditionSpec

---@alias MasonPackageSpec string | MasonPackageStruct

-- Language configuration specification
---@class LanguageSpec
---@field treesitter? boolean | string | string[] Treesitter parsers to install. `true` uses lang name, `false` skips, or specify parser name(s).
---@field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
---@field lsp? string | string[] | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
---@field formatter? string | string[] | table<string, string|string[]> Formatters. `string` uses lang_name, `string[]` uses lang_name with multiple formatters, or `table` for explicit filetype mapping.
---@field linter? string | string[] | table<string, string|string[]> Linters. `string` uses lang_name, `string[]` uses lang_name with multiple linters, or `table` for explicit filetype mapping.
---@field dap? table DAP (Debug Adapter Protocol) configuration
---@field plugins? LazyPluginSpec | LazyPluginSpec[] Plugins to install. Can be a single plugin spec or a list of plugin specs.

---@class ToolSpec
---@field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
---@field lsp? string | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
---@field formatter? table<string, string|string[]> Formatters by filetype. Must be explicit filetype mapping (e.g., { html = "prettier", css = "prettier" }).
---@field linter? table<string, string[]> Linters by filetype. Must be explicit filetype mapping (e.g., { javascript = { "eslint" } }).
---@field plugins? LazyPluginSpec | LazyPluginSpec[] Extra plugins to install. Can be a single plugin spec or a list of plugin specs.
