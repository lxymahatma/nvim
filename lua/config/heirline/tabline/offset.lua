local icons = require("config.icons")

return {
    static = {
        separator = icons.bufferline.separator,
    },
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        self.winid = win
        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "snacks_layout_box"
    end,
    provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid)) .. self.separator end,
    hl = { fg = "crust" },
}
