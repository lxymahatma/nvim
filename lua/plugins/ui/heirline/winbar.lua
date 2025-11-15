local M = {}

function M.get()
    local WinBarFileName = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
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
