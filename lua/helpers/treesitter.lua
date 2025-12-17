local M = {}

local ts = require("nvim-treesitter")

---@param parser_list string[] List of parser names to ensure are installed
M.ensure_parsers_installed = function(parser_list) ts.install(parser_list, { force = false, summary = true }) end

---@param parser_name string
M.install_parser = function(parser_name)
    vim.notify(("[treesitter] Installing parser: %s"):format(parser_name), vim.log.levels.INFO)
    ts.install(parser_name, { force = false, summary = true })
end

---@param parser_name string
M.update_parser = function(parser_name)
    vim.notify(("[treesitter] Updating parser: %s"):format(parser_name), vim.log.levels.INFO)
    ts.update(parser_name, { summary = false })
end

return M
