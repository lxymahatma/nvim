--- @meta

-- Language configuration specification
--- @class LanguageSpec
--- @field treesitter true | string | string[] Treesitter parsers to install. `true` uses lang name, or specify parser name(s).
--- @field filetype? string | string[] Filetype(s) associated with the language.
--- @field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
--- @field lsp? string | string[] | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
--- @field formatter? string | conform.FiletypeFormatter | table<string, string | conform.FiletypeFormatter> Formatters. `string` for single filetype, `conform.FiletypeFormatter` formultiple filetypes with optional conform options, or `table` for explicit filetype mapping.
--- @field linter? string | string[] | table<string, string|string[]> Linters. `string` uses lang_name, `string[]` specifies multiple linter tools for lang_name filetype, or `table` for explicit filetype mapping.
--- @field dap? table DAP (Debug Adapter Protocol) configuration
--- @field plugin? LazyPluginSpec | LazyPluginSpec[] Extra plugin(s) to install. Can be a single plugin spec or a list of plugin specs.
--- @field on_attach? fun(bufnr: integer) Called once on FileType.

-- Tool configuration specification
--- @class ToolSpec
--- @field filetype string | string[] Filetype(s) associated with the language.
--- @field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install. Can be a single package name/spec or a list of package names/specs.
--- @field lsp? string | table<string, vim.lsp.ClientConfig> LSP servers configuration. Can be a single server name (default config) or (server_name -> config) map.
--- @field formatter? string | string[] | table<string, string|string[]> Formatters. `string` uses tool_name, `string[]` specifies multiple filetypes that tool_name formats, or `table` for explicit filetype mapping.
--- @field linter? string | string[] | table<string, string | string[]> Linters. `string` uses tool_name, `string[]` specifies multiple filetypes that tool_name lints, or `table` for explicit filetype mapping.
--- @field plugin? LazyPluginSpec | LazyPluginSpec[] Extra plugin(s) to install. Can be a single plugin spec or a list of plugin specs.

-- Toolchain UI
--- @alias ToolchainType "lang" | "tool"
--- @alias ToolchainTab "all" | ToolchainType

--- @class ToolchainItem
--- @field name string
--- @field type ToolchainType
--- @field enabled boolean
--- @field is_default boolean

--- @class ToolchainUIOptions
--- @field width? integer
--- @field height? integer

--- @class ToolchainRenderContext
--- @field buf integer?
--- @field win integer?
--- @field state ToolchainState

--- @class ToolchainRenderHighlight
--- @field line integer
--- @field col_start integer
--- @field col_end integer
--- @field hl string

--- @class ToolchainRenderChunk
--- @field lines string[]
--- @field highlights? ToolchainRenderHighlight[]
