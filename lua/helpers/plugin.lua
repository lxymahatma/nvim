local M = {}

--- @param name string
--- @return LazyPlugin
function M.get_plugin(name) return require("lazy.core.config").spec.plugins[name] end

--- @param name string
--- @return LazyPluginSpec
function M.opts(name)
    local plugin = M.get_plugin(name)
    return require("lazy.core.plugin").values(plugin, "opts", false)
end

return M
