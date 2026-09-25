local ts = require("nvim-treesitter")

local M = {}

---@param parser_list string[] List of parser names to ensure are installed
M.ensure_parsers_installed = function(parser_list) ts.install(parser_list) end

return M
