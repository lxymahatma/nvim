---@meta

-- Mason Package Specification
---@class ConditionOptions
---@field missing? string|boolean If string, checks that specific executable. If true, use the package name as executable name.

---@alias ConditionSpec fun(): boolean | ConditionOptions

---@class MasonPackageStruct
---@field [1] string Package name
---@field condition? ConditionSpec

---@alias MasonPackageSpec string | MasonPackageStruct

-- Language configuration specification
---@class LanguageSpec
---@field treesitter true | string | string[] Treesitter parsers to install. `true` uses lang name, or specify parser name(s).
---@field filetype? string | string[] Filetype(s) associated with the language.
---@field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
---@field lsp? string | string[] | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
---@field formatter? string | string[] | table<string, string|string[]> Formatters. `string` uses lang_name, `string[]` specifies multiple formatter tools for lang_name filetype, or `table` for explicit filetype mapping.
---@field linter? string | string[] | table<string, string|string[]> Linters. `string` uses lang_name, `string[]` specifies multiple linter tools for lang_name filetype, or `table` for explicit filetype mapping.
---@field dap? table DAP (Debug Adapter Protocol) configuration
---@field plugin? LazyPluginSpec | LazyPluginSpec[] Extra plugin(s) to install. Can be a single plugin spec or a list of plugin specs.

-- Tool configuration specification
---@class ToolSpec
---@field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
---@field lsp? string | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
---@field formatter? string | string[] | table<string, string|string[]> Formatters. `string` uses tool_name, `string[]` specifies multiple filetypes that tool_name formats, or `table` for explicit filetype mapping.
---@field linter? string | string[] | table<string, string | string[]> Linters. `string` uses tool_name, `string[]` specifies multiple filetypes that tool_name lints, or `table` for explicit filetype mapping.
---@field plugin? LazyPluginSpec | LazyPluginSpec[] Extra plugin(s) to install. Can be a single plugin spec or a list of plugin specs.
