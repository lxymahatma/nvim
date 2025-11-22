return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
        local conditions = require("heirline.conditions")

        local colors = require("heirline.colors")
        local tabline = require("heirline.layouts.tabline")
        local statusline = require("heirline.layouts.statusline")
        local winbar = require("heirline.layouts.winbar")

        require("heirline").setup({
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
        })
    end,
}
