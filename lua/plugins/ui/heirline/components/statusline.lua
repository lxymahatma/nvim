local M = {}

local icons = require("config.icons")
local conditions = require("heirline.conditions")
local common = require("plugins.ui.heirline.components.common")

M.ViMode = {
    static = {
        mode_names = {
            n = "NORMAL",
            no = "O-PENDING",
            nov = "O-PENDING",
            noV = "O-PENDING",
            ["no\22"] = "O-PENDING",
            niI = "NORMAL",
            niR = "NORMAL",
            niV = "NORMAL",
            nt = "NORMAL",
            v = "VISUAL",
            vs = "VISUAL",
            V = "V-LINE",
            Vs = "V-LINE",
            ["\22"] = "V-BLOCK",
            ["\22s"] = "V-BLOCK",
            s = "SELECT",
            S = "S-LINE",
            ["\19"] = "S-BLOCK",
            i = "INSERT",
            ic = "INSERT",
            ix = "INSERT",
            R = "REPLACE",
            Rc = "REPLACE",
            Rx = "REPLACE",
            Rv = "V-REPLACE",
            Rvc = "V-REPLACE",
            Rvx = "V-REPLACE",
            c = "COMMAND",
            cv = "EX",
            ce = "EX",
            r = "REPLACE",
            rm = "MORE",
            ["r?"] = "CONFIRM",
            ["!"] = "SHELL",
            t = "TERMINAL",
        },
        sep = icons.LeftSectionSep .. " ",
    },
    provider = function(self) return " %2(" .. self.mode_names[self.mode] .. "%) " end,
    hl = function(self)
        return {
            fg = "surface0",
            bg = self.mode_colors[self.mode_key],
            bold = true,
        }
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
}

M.Git = {
    condition = conditions.is_git_repo,
    static = {
        branch = icons.branch,
    },
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { bg = "surface0" },
    {
        provider = function(self) return self.branch .. self.status_dict.head .. " " end,
        hl = function(self)
            return {
                fg = self.mode_colors[self.mode_key],
            }
        end,
    },
    {
        condition = function(self) return self.has_changes end,
        provider = function(self) return self.left_component_sep end,
        hl = { fg = "text" },
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count .. " ")
        end,
        hl = {
            fg = "git_add",
        },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count .. " ")
        end,
        hl = {
            fg = "git_change",
        },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count .. " ")
        end,
        hl = {
            fg = "git_del",
        },
    },
}

M.Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = icons.diagnostics.Error,
        warn_icon = icons.diagnostics.Warn,
        info_icon = icons.diagnostics.Info,
        hint_icon = icons.diagnostics.Hint,
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self) return self.errors > 0 and (self.error_icon .. self.errors .. " ") end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") end,
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. " ") end,
        hl = { fg = "diag_info" },
    },
    {
        provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints .. " ") end,
        hl = { fg = "diag_hint" },
    },
}

M.FileType = {
    common.FileIcon,
    {
        provider = function() return vim.bo.filetype end,
        hl = { fg = "text" },
    },
}

M.SideKickCopilot = {
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

M.SideKickCli = {
    condition = function() return #require("sidekick.status").cli() > 0 end,
    init = function(self) self.status = require("sidekick.status").cli() end,
    {
        provider = function(self) return "  " .. (#self.status > 1 and #self.status or "") end,
        hl = { fg = Snacks.util.color("Special") },
    },
    update = { "User", pattern = { "SidekickCliAttach", "SidekickCliDetach" } },
}

M.FileEncoding = {
    {
        provider = function()
            local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
            local bomb = vim.bo.bomb and "[BOM]" or ""
            return " " .. enc:upper() .. bomb
        end,
        hl = { fg = "text" },
    },
}

M.FileFormat = {
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

M.Progress = {
    provider = function(self)
        if self.line == 1 then
            return "Top"
        elseif self.line == self.total then
            return "Bot"
        else
            local percent = math.floor((self.line / self.total) * 100)
            return string.format("%3d%%%%", percent)
        end
    end,
    hl = function(self)
        return {
            fg = self.mode_colors[self.mode_key],
            bg = "surface0",
        }
    end,
}

M.Location = {
    provider = function(self) return string.format("%4d:%-3d", self.line, self.charcol) end,
    hl = function(self)
        return {
            fg = "surface0",
            bg = self.mode_colors[self.mode_key],
            bold = true,
        }
    end,
}

return M
