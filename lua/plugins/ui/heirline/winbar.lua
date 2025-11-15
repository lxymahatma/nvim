local M = {}

function M.get()
    local FilePath = {
        init = function(self) self.filepath = vim.api.nvim_buf_get_name(0) end,
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filepath, ":~")
            return " " .. filename
        end,
        hl = { fg = "overlay0", italic = true },
    }

    return { FilePath }
end

return M
