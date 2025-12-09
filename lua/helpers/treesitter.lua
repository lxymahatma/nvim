local M = {}

local ts = require("nvim-treesitter")

---@param parser_list string[] List of parser names to ensure are installed
M.ensure_parsers_installed = function(parser_list)
    local installed_set = require("helpers.table").to_set(ts.get_installed())

    local install_list = {}
    local update_list = {}

    for _, parser_name in ipairs(parser_list) do
        if not installed_set[parser_name] then
            table.insert(install_list, parser_name)
        else
            table.insert(update_list, parser_name)
        end
    end

    if #install_list > 0 then ts.install(install_list, { force = false, summary = true }) end
    if #update_list > 0 then ts.update(update_list, { summary = false }) end
end

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
