local icons = require("config.icons")

return {
    static = {
        modified_icon = " " .. icons.bufferline.modified,
    },
    provider = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) and self.modified_icon or "  " end,
    hl = { fg = "orange" },
}
