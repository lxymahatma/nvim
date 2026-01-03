local icons = require("config.icons")

return {
    static = {
        modified_icon = " " .. icons.bufferline.modified,
    },
    provider = function(self) return self.modified and self.modified_icon or "  " end,
    hl = { fg = "peach" },
}
