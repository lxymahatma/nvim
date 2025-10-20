local M = {}

function M.setup(enabled_langs)
    local spec = {
        { import = "plugins" },
        { import = "plugins.coding" },
        { import = "plugins.highlight" }
    }
    for _, lang in ipairs(enabled_langs) do
        table.insert(spec, { import = ("plugins.lang.%s"):format(lang) })
    end

    require("lazy").setup({ spec = spec })
end

return M
