local M = {}

M.Indicator = {
    static = {
        indicator = "▎",
    },
    condition = function(self) return self.is_active end,
    provider = function(self) return self.indicator end,
    hl = { fg = "orange" },
}

M.BufferPadding = {
    provider = "  ",
}

M.FileName = {
    provider = function(self)
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return filename
    end,
    hl = function(self)
        return {
            bold = self.is_active,
            italic = self.is_active,
        }
    end,
}

M.Diagnostics = {
    condition = function(self) return #vim.diagnostic.get(self.bufnr) > 0 end,
    init = function(self)
        local diagnostics = vim.diagnostic.get(self.bufnr)
        self.errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diagnostics)
        self.warnings = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diagnostics)
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self) return self.errors > 0 and (" " .. self.errors) or "" end,
        hl = { fg = "diag_error", bold = true },
    },
    {
        provider = function(self) return self.warnings > 0 and (" " .. self.warnings) or "" end,
        hl = { fg = "diag_warn", bold = true },
    },
}

M.FileFlags = {
    condition = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
    provider = " ●",
    hl = { fg = "orange" },
}

M.Offset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        ---@cast win integer

        self.winid = win
        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "snacks_layout_box"
    end,
    provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid)) end,
}

return M
