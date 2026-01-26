-- Statusline, Winbar and Tabline
--- @type LazyPluginSpec
return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    opts = function()
        local conditions = require("heirline.conditions")
        local colors = require("config.colors").catppuccin

        return {
            statusline = require("config.heirline.statusline"),
            winbar = require("config.heirline.winbar"),
            tabline = require("config.heirline.tabline"),
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
