local M = {}

function M.setup(colors)
    local WinBarFileName = {
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
            self.is_edit_win = require("helpers.window").is_edit_window()
        end,
        condition = function(self) return self.is_edit_win end,
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ":~:.")
            if filename == "" then filename = "[No Name]" end
            return " " .. filename
        end,
        hl = { fg = "gray", italic = true },
    }

    return { WinBarFileName }
end

return M
