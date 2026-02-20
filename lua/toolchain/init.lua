local loader = require("toolchain.loader")
local lang_parser = require("toolchain.lang.parser")
local tool_parser = require("toolchain.tool.parser")
local table_helper = require("helpers.table")

local M = {}

function M.setup()
    loader.load()
    lang_parser.load_all()
    tool_parser.load_all()
end

--- @param filetype string
function M.get_config_by_ft(filetype)
    local lang_cfg = lang_parser.get_config_by_ft(filetype)
    local tool_cfg = tool_parser.get_config_by_ft(filetype)

    if not lang_cfg and not tool_cfg then return nil end
    return vim.tbl_deep_extend("force", lang_cfg or {}, tool_cfg or {})
end

--- @return MasonPackageSpec[]
function M.get_mason_packages() return table_helper.list_merge(lang_parser.get_mason_packages(), tool_parser.get_mason_packages()) end

--- @return table<string, vim.lsp.ClientConfig>
function M.get_lsp_servers() return vim.tbl_extend("force", lang_parser.get_lsp_servers(), tool_parser.get_lsp_servers()) end

--- @return table<string, conform.FiletypeFormatter>
function M.get_formatters() return vim.tbl_deep_extend("force", lang_parser.get_formatters(), tool_parser.get_formatters()) end

--- @return table<string, conform.FormatterConfigOverride>
function M.get_formatter_overrides() return vim.tbl_deep_extend("force", lang_parser.get_formatter_overrides(), tool_parser.get_formatter_overrides()) end

--- @return table<string, string[]>
function M.get_linters() return vim.tbl_extend("force", lang_parser.get_linters(), tool_parser.get_linters()) end

--- @return LazyPluginSpec[]
function M.get_extra_plugins() return table_helper.list_merge(lang_parser.get_extra_plugins(), tool_parser.get_extra_plugins()) end

return M
