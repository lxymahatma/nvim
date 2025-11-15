local M = {}

M.FileIcon = {
    init = function(self)
        self.icon, self.icon_hl = require("mini.icons").get("file", self.filename)
        self.icon_color = string.format("#%06x", vim.api.nvim_get_hl(0, { name = self.icon_hl }).fg)
    end,
    provider = function(self) return self.icon and (self.icon .. " ") end,
    hl = function(self) return { fg = self.icon_color } end,
}

return M
