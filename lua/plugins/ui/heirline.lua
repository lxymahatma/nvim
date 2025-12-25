-- Statusline, Winbar and Tabline
---@type LazyPluginSpec
return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    opts = function()
        local conditions = require("heirline.conditions")

        local colors = require("config.colors")
        local tabline = require("heirline.layouts.tabline")
        local statusline = require("heirline.layouts.statusline")
        local winbar = require("heirline.layouts.winbar")

        return {
            statusline = statusline,
            winbar = winbar,
            tabline = tabline,
            opts = {
                colors = colors,
                disable_winbar_cb = function(args)
                    return conditions.buffer_matches({
                        buftype = { "nofile" },
                        filetype = { "snacks_picker_list" },
                    }, args.buf)
                end,
            },
        }
    end,
}
