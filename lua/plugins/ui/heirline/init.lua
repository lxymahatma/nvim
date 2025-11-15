return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
        local conditions = require("heirline.conditions")

        local colors = require("plugins.ui.heirline.colors").colors
        local tabline = require("plugins.ui.heirline.tabline")
        local statusline = require("plugins.ui.heirline.statusline")
        local winbar = require("plugins.ui.heirline.winbar")

        require("heirline").setup({
            statusline = statusline.get(),
            winbar = winbar.get(),
            tabline = tabline.get(),
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
