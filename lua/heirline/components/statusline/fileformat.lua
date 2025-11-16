local icons = require("config.icons")

return {
    static = {
        symbols = {
            unix = icons.fileformat.unix,
            dos = icons.fileformat.dos,
            mac = icons.fileformat.mac,
        },
    },
    provider = function(self) return " " .. self.symbols[vim.bo.fileformat] end,
    hl = { fg = "text" },
}
