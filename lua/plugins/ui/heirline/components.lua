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

-- Status Line Components
M.ViMode = {
    init = function(self) self.mode = vim.fn.mode(1) end,
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
        mode_colors = {
            n = "blue",
            i = "green",
            v = "purple",
            V = "purple",
            ["\22"] = "purple",
            c = "orange",
            s = "purple",
            S = "purple",
            ["\19"] = "purple",
            R = "red",
            r = "red",
            ["!"] = "red",
            t = "green",
        },
    },
    provider = function(self) return " %2(" .. self.mode_names[self.mode] .. "%) " end,
    hl = function(self)
        local mode = self.mode:sub(1, 1)
        return {
            fg = "surface0",
            bg = self.mode_colors[mode],
            bold = true,
        }
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
    },
}

M.StatusLineDiagnostics = {
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
    provider = function() return vim.bo.filetype end,
    hl = { fg = "bright_fg" },
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
    provider = function(self) return self.status and vim.tbl_get(self.icons, self.status.kind, 1) end,
    hl = function(self)
        local hl = self.status and (self.status.busy and "DiagnosticWarn" or vim.tbl_get(self.icons, self.status.kind, 2))
        return { fg = Snacks.util.color(hl) }
    end,
    update = { "User", pattern = { "SidekickNesDone", "SidekickNesHide", "SidekickNesShow" } },
}

M.SideKickCli = {
    condition = function() return #require("sidekick.status").cli() > 0 end,
    provider = function()
        local status = require("sidekick.status").cli()
        return " " .. (#status > 1 and #status or "") .. " "
    end,
    hl = { fg = "cyan" },
    update = { "User", pattern = { "SidekickCliAttach", "SidekickCliDetach" } },
}

M.FileEncoding = {
    provider = function()
        local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
        local bomb = vim.bo.bomb and "[BOM]" or ""
        return enc:upper() .. bomb .. " "
    end,
    hl = { fg = "bright_fg" },
}

M.FileFormat = {
    static = {
        symbols = {
            unix = icons.fileformat.unix,
            dos = icons.fileformat.dos,
            mac = icons.fileformat.mac,
        },
    },
    provider = function(self) return self.symbols[vim.bo.fileformat] .. " " end,
    hl = { fg = "bright_fg" },
}

M.Progress = {
    provider = function(self)
        if self.line == 1 then
            return "Top"
        elseif self.line == self.total then
            return "Bot"
        else
            local percent = math.floor((self.line / self.total) * 100)
            return string.format("%2d%%%%", percent)
        end
    end,
    hl = { fg = "bright_fg", bold = true },
}

M.Location = {
    provider = function(self) return string.format("%3d:%-2d", self.line, self.charcol) end,
    hl = {
        fg = "surface0",
        bg = "blue",
        bold = true,
    },
}

return M
