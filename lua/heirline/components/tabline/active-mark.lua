local icons = require("config.icons")

return {
    static = {
        active_icon = icons.bufferline.active .. " ",
    },
    provider = function(self) return self.is_active and self.active_icon or "  " end,
    hl = { fg = "orange" },
}
