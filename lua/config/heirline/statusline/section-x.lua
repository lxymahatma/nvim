local icons = require("config.icons")

local SidekickCopilot = {
    condition = function() return require("sidekick.status").get() ~= nil end,
    static = {
        icons = {
            Error = { icons.copilot.Error, "DiagnosticError" },
            Inactive = { icons.copilot.Inactive, "MsgArea" },
            Warning = { icons.copilot.Warning, "DiagnosticWarn" },
            Normal = { icons.copilot.Normal, "Special" },
        },
    },
    init = function(self) self.status = require("sidekick.status").get() end,
    {
        provider = function(self) return self.status and vim.tbl_get(self.icons, self.status.kind, 1) end,
        hl = function(self)
            local hl = self.status and (self.status.busy and "DiagnosticWarn" or vim.tbl_get(self.icons, self.status.kind, 2))
            return { fg = Snacks.util.color(hl) }
        end,
    },
    {
        provider = function(self) return self.sep.right_component end,
        hl = { fg = "text" },
    },
    update = { "User", pattern = { "SidekickNesDone", "SidekickNesHide", "SidekickNesShow" } },
}

local SidekickCli = {
    condition = function() return #require("sidekick.status").cli() > 0 end,
    init = function(self) self.status = require("sidekick.status").cli() end,
    {
        provider = function(self) return "  " .. (#self.status > 1 and #self.status or "") end,
        hl = { fg = Snacks.util.color("Special") },
    },
    {
        provider = function(self) return self.sep.right_component end,
        hl = { fg = "text" },
    },
    update = { "User", pattern = { "SidekickCliAttach", "SidekickCliDetach" } },
}

local Encoding = {
    {
        provider = function()
            local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
            local bomb = vim.bo.bomb and "[BOM]" or ""
            return " " .. enc:upper() .. bomb
        end,
        hl = { fg = "text" },
    },
    {
        provider = function(self) return self.sep.right_component end,
        hl = { fg = "text" },
    },
}

local FileFormat = {
    static = {
        symbols = {
            unix = icons.fileformat.unix,
            dos = icons.fileformat.dos,
            mac = icons.fileformat.mac,
        },
    },
    provider = function(self) return " " .. self.symbols[vim.bo.fileformat] end,
    hl = { fg = "text" },
}

return {
    SidekickCopilot,
    SidekickCli,
    Encoding,
    FileFormat,
}
