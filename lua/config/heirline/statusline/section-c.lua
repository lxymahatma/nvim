local icons = require("config.icons")
local conditions = require("heirline.conditions")

local FileIcon = require("config.heirline.common.fileicon")

local Diagnostics = {
    condition = conditions.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self) return self.errors > 0 and (icons.diagnostics.Error .. self.errors .. " ") end,
        hl = "DiagnosticSignError",
    },
    {
        provider = function(self) return self.warnings > 0 and (icons.diagnostics.Warn .. self.warnings .. " ") end,
        hl = "DiagnosticSignWarn",
    },
    {
        provider = function(self) return self.info > 0 and (icons.diagnostics.Info .. self.info .. " ") end,
        hl = "DiagnosticSignInfo",
    },
    {
        provider = function(self) return self.hints > 0 and (icons.diagnostics.Hint .. self.hints .. " ") end,
        hl = "DiagnosticSignHint",
    },
    {
        provider = function(self) return self.sep.left_component end,
        hl = { fg = "text" },
    },
}

local FileType = {
    FileIcon,
    {
        provider = function() return vim.bo.filetype end,
        hl = { fg = "text" },
    },
}

return {
    Diagnostics,
    FileType,
}
