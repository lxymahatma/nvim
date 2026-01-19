local icons = require("config.icons").bufferline

return {
    static = {
        active_icon = icons.active .. " ",
    },
    provider = function(self) return self.is_active and self.active_icon or "  " end,
    hl = { fg = "peach" },
}
