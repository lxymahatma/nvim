local M = {}

local lang_parser = require("helpers.lang-parser")
local tool_parser = require("helpers.tool-parser")

lang_parser.load_all()
tool_parser.load_all()

function M.setup()
    local plugin_spec = {
        { import = "plugins" },
        { import = "plugins.coding" },
        { import = "plugins.deps" },
        { import = "plugins.editor" },
        { import = "plugins.highlight" },
        { import = "plugins.qol" },
        { import = "plugins.ui" },
    }

    vim.list_extend(plugin_spec, lang_parser.get_extra_plugins())
    vim.list_extend(plugin_spec, tool_parser.get_extra_plugins())

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
