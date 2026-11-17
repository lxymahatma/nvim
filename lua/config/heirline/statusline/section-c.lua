local icons = require("config.icons").diagnostics
local conditions = require("heirline.conditions")

local FileIcon = require("config.heirline.common.fileicon")

local Diagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    local counts = vim.diagnostic.count(0)
    self.errors = counts[vim.diagnostic.severity.ERROR]
    self.warnings = counts[vim.diagnostic.severity.WARN]
    self.info = counts[vim.diagnostic.severity.INFO]
    self.hints = counts[vim.diagnostic.severity.HINT]
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self) return self.errors and (icons.Error .. self.errors .. " ") end,
    hl = "DiagnosticSignError",
  },
  {
    provider = function(self) return self.warnings and (icons.Warn .. self.warnings .. " ") end,
    hl = "DiagnosticSignWarn",
  },
  {
    provider = function(self) return self.info and (icons.Info .. self.info .. " ") end,
    hl = "DiagnosticSignInfo",
  },
  {
    provider = function(self) return self.hints and (icons.Hint .. self.hints .. " ") end,
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
