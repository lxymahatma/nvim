local M = {}

function M.setup(enabled_langs)
    local plugin_spec = {
        { import = "plugins" },
        { import = "plugins.coding" },
        { import = "plugins.deps" },
        { import = "plugins.editor" },
        { import = "plugins.highlight" },
        { import = "plugins.qol" },
        { import = "plugins.ui" },
    }
    for _, lang in ipairs(enabled_langs) do
        table.insert(plugin_spec, { import = ("plugins.lang.%s"):format(lang) })
    end

    ---@type LazyConfig
    local opts = {
        spec = plugin_spec,
        dev = {
            path = function(plugin)
                local dir = vim.env.NVIM_DEV_DIR or ""
                return vim.fs.joinpath(dir, plugin.name)
            end,
            patterns = { "." },
            fallback = true,
        },
    }

    require("lazy").setup(opts)
end

return M
