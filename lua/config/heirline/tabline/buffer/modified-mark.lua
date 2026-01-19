local icons = require("config.icons").bufferline

return {
    static = {
        modified_icon = " " .. icons.modified,
    },
    provider = function(self) return self.modified and self.modified_icon or "  " end,
    hl = { fg = "peach" },
}
