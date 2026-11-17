---@meta

---@alias ToolchainType "lang" | "tool"

-- Toolchain type, see `constant.toolchain_types`
---@class ToolchainTypeConfig
---@field name ToolchainType
---@field defaults string[] Specs that are always enabled.

-- Toolchain configuration specification, shared by languages and tools
---@class ToolchainSpec
---@field filetype? string | string[] Filetype(s) that formatters, linters, dap configurations, keymaps and `on_attach` apply to.
---@field treesitter? true | string | string[] Treesitter parsers to install. `true` uses spec name.
---@field mason? MasonPackageSpec | MasonPackageSpec[] Mason packages to install.
---@field lsp? string | string[] | table<string, vim.lsp.Config> LSP servers. Server name(s) use default config, or a (server_name -> config) map. Both can be mixed.
---@field formatter? true | string | conform.FiletypeFormatterInternal | table<string, string | conform.FiletypeFormatterInternal> Formatters. `true` uses spec name, `string` or a list (with optional conform options) applies to every filetype, or a (filetype -> formatters) map.
---@field formatter_opts? table<string, conform.FormatterConfigOverride> Conform formatter overrides, e.g. `{ yamlfmt = { append_args = {...} } }`.
---@field linter? string | string[] | table<string, string | string[]> Linters. `string` or `string[]` applies to every filetype, or a (filetype -> linters) map.
---@field dap_configurations? dap.Configuration[] nvim-dap configurations for every `filetype`, e.g. `{ { type = "python", request = "launch", name = "Launch file", program = "${file}" } }`.
---@field dap_adapters? table<string, dap.Adapter | dap.AdapterFactory> nvim-dap adapters by name, e.g. `{ python = { type = "executable", command = "python", args = { "-m", "debugpy.adapter" } } }`.
---@field plugin? string | LazyPluginSpec | LazyPluginSpec[] Extra plugins to install.
---@field keymaps? snacks.Keymap[] Keymaps to register. `opts.ft` defaults to `filetype`.
---@field on_attach? fun(bufnr: integer) Called on FileType for every `filetype`.
---@field exclusive? string Exclusive group, e.g. `"web-formatter"`. Only one spec of a group can be enabled.

-- Language configuration specification, `filetype` defaults to the spec name
---@class LanguageSpec: ToolchainSpec
---@field treesitter true | string | string[]

-- Tool configuration specification, `filetype` has no default
---@class ToolSpec: ToolchainSpec

-- Toolchain UI
---@alias ToolchainTab "all" | ToolchainType

---@class ToolchainItem
---@field name string
---@field type ToolchainType
---@field module string
---@field enabled boolean
---@field is_default boolean
