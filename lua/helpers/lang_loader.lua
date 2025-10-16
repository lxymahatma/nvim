local M = {}

function M.get_extra_langs()
    local ok, local_config = pcall(require, "config.local")
    if not ok then return {} end
    return local_config.extra_languages or {}
end

return M
