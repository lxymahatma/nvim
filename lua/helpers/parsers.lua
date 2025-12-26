local M = {}

local lang_parser = require("langs.lang-parser")
local tool_parser = require("tools.tool-parser")
local table_helper = require("helpers.table")

M.setup = function()
    lang_parser.load_all()
    tool_parser.load_all()
end

M.get_mason_packages = function() return table_helper.list_merge(lang_parser.get_mason_packages(), tool_parser.get_mason_packages()) end

M.get_lsp_servers = function() return vim.tbl_extend("force", lang_parser.get_lsp_servers(), tool_parser.get_lsp_servers()) end

M.get_formatters = function() return vim.tbl_extend("force", lang_parser.get_formatters(), tool_parser.get_formatters()) end

M.get_linters = function() return vim.tbl_extend("force", lang_parser.get_linters(), tool_parser.get_linters()) end

M.get_extra_plugins = function() return table_helper.list_merge(lang_parser.get_extra_plugins(), tool_parser.get_extra_plugins()) end

return M
