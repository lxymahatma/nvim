return {
    {
        init = function(self) self.filepath = vim.api.nvim_buf_get_name(0) end,
        provider = function(self)
            local filename = self.filepath == "" and "[No Name]" or vim.fn.fnamemodify(self.filepath, ":~")
            return " " .. filename
        end,
        hl = { fg = "overlay0", italic = true },
    },
}
