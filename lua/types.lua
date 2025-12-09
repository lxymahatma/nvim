---@meta

-- Mason Package Specification

---@class ConditionOptions
---@field missing? string|boolean If string, checks that specific executable. If true, use the package name as executable name.

---@alias ConditionSpec fun(): boolean | ConditionOptions

---@alias MasonPackageSpec string | { [1]: string, condition?: ConditionSpec }

-- Language configuration specification
---@class LanguageSpec
---@field treesitter? string|string[] Treesitter parsers to install
---@field mason? MasonPackageSpec|MasonPackageSpec[] Mason packages to install
---@field lsp? table<string, vim.lsp.ClientConfig> LSP servers configuration (server_name -> config)
---@field formatter? table<string, string|string[]> Formatters by filetype (filetype -> formatters)
---@field linter? table<string, string|string[]> Linters by filetype (filetype -> linters)
---@field dap? table DAP (Debug Adapter Protocol) configuration
