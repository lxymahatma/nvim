local M = {}

local lang_parser = require("langs.lang-parser")
local tool_parser = require("tools.tool-parser")

M.setup = function()
    lang_parser.load_all()
    tool_parser.load_all()
end

M.get_extra_plugins = function() return vim.list_extend(lang_parser.get_extra_plugins(), tool_parser.get_extra_plugins()) end

return M
