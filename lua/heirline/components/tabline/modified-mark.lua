local icons = require("config.icons")

return {
    static = {
        modified_icon = " " .. icons.bufferline.modified,
    },
    init = function(self) self.modified = vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
    provider = function(self) return self.modified and self.modified_icon or "  " end,
    hl = { fg = "orange" },
}
