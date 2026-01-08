local lang_parser = require("toolchain.lang.parser")
local tool_parser = require("toolchain.tool.parser")
local table_helper = require("helpers.table")

local M = {}

M.setup = function()
    lang_parser.load_all()
    tool_parser.load_all()
end

--- @param filetype string
M.get_config_by_ft = function(filetype)
    local lang_cfg = lang_parser.get_config_by_ft(filetype)
    local tool_cfg = tool_parser.get_config_by_ft(filetype)

    if not lang_cfg and not tool_cfg then return nil end
    return vim.tbl_deep_extend("force", lang_cfg or {}, tool_cfg or {})
end

--- @return MasonPackageSpec[]
M.get_mason_packages = function() return table_helper.list_merge(lang_parser.get_mason_packages(), tool_parser.get_mason_packages()) end

--- @return table<string, vim.lsp.ClientConfig>
M.get_lsp_servers = function() return vim.tbl_extend("force", lang_parser.get_lsp_servers(), tool_parser.get_lsp_servers()) end

--- @return table<string, conform.FiletypeFormatter>
M.get_formatters = function() return vim.tbl_deep_extend("force", lang_parser.get_formatters(), tool_parser.get_formatters()) end

--- @return table<string, string[]>
M.get_linters = function() return vim.tbl_extend("force", lang_parser.get_linters(), tool_parser.get_linters()) end

--- @return LazyPluginSpec[]
M.get_extra_plugins = function() return table_helper.list_merge(lang_parser.get_extra_plugins(), tool_parser.get_extra_plugins()) end

return M
