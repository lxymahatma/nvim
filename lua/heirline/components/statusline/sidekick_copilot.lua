local icons = require("config.icons")

return {
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
        provider = function(self) return self.right_component_sep end,
        hl = { fg = "text" },
    },
    update = { "User", pattern = { "SidekickNesDone", "SidekickNesHide", "SidekickNesShow" } },
}
