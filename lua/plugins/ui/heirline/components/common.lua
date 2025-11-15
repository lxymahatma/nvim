local M = {}

local conditions = require("heirline.conditions")
local icons = require("config.icons")

M.Space = { provider = " " }

M.FileIcon = {
    init = function(self)
        self.icon, self.icon_hl = require("mini.icons").get("file", self.filename)
        self.icon_color = string.format("#%06x", vim.api.nvim_get_hl(0, { name = self.icon_hl }).fg)
    end,
    provider = function(self) return self.icon and (self.icon .. " ") end,
    hl = function(self) return { fg = self.icon_color } end,
}

M.FileNameBlock = {
    init = function(self)
        local bufnr = self.bufnr or 0
        self.filename = vim.api.nvim_buf_get_name(bufnr)
    end,
    M.FileIcon,
}

M.FilePathBlock = {
    init = function(self)
        local bufnr = self.bufnr or 0
        self.filename = vim.api.nvim_buf_get_name(bufnr)
    end,
    M.FileIcon,
}

-- Tabline Components
M.TablineDiagnostics = {
    condition = function(self) return #vim.diagnostic.get(self.bufnr) > 0 end,
    init = function(self)
        local diagnostics = vim.diagnostic.get(self.bufnr)
        self.errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diagnostics)
        self.warnings = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diagnostics)
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self) return self.errors > 0 and (" " .. self.errors) or "" end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self) return self.warnings > 0 and (" " .. self.warnings) or "" end,
        hl = { fg = "diag_warn" },
    },
}

return M
