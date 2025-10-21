local M = {}

function M.setup(enabled_langs)
    local spec = {
        { import = "plugins" },
        { import = "plugins.coding" },
        { import = "plugins.editor" },
        { import = "plugins.highlight" },
        { import = "plugins.qol" },
        { import = "plugins.ui" },
        { import = "plugins.utils" },
    }
    for _, lang in ipairs(enabled_langs) do
        table.insert(spec, { import = ("plugins.lang.%s"):format(lang) })
    end

    require("lazy").setup({ spec = spec })
end

return M
