local M = {}

M.FileIcon = {
    init = function(self)
        if self.bufnr then
            self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        else
            self.filename = vim.api.nvim_buf_get_name(0)
        end

        self.icon, self.icon_hl, _ = require("mini.icons").get("file", self.filename)

        if self.icon_hl then
            local hl = vim.api.nvim_get_hl(0, { name = self.icon_hl })
            self.icon_color = hl.fg and string.format("#%06x", hl.fg) or "#ffffff"
        else
            self.icon_color = "#ffffff"
        end
    end,
    provider = function(self) return self.icon and (self.icon .. " ") end,
    hl = function(self) return { fg = self.icon_color } end,
}

return M
