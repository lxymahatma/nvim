local M = {}

function M.setup(colors)
    local conditions = require("heirline.conditions")

    local Align = { provider = "%=" }
    local Space = { provider = " " }

    local ViMode = {
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
            return { fg = "bright_bg", bg = self.mode_colors[mode], bold = true }
        end,
        update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
        },
    }

    local Git = {
        condition = conditions.is_git_repo,
        init = function(self) self.status_dict = vim.b.gitsigns_status_dict end,
        hl = { fg = "orange" },
        {
            provider = function(self) return "  " .. self.status_dict.head .. " " end,
        },
        {
            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ("+" .. count .. " ")
            end,
            hl = { fg = "git_add" },
        },
        {
            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ("~" .. count .. " ")
            end,
            hl = { fg = "git_change" },
        },
        {
            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ("-" .. count .. " ")
            end,
            hl = { fg = "git_del" },
        },
    }

    local Diagnostics = {
        condition = conditions.has_diagnostics,
        static = {
            error_icon = " ",
            warn_icon = " ",
            info_icon = " ",
            hint_icon = " ",
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

    local FileType = {
        init = function(self)
            local filename = vim.api.nvim_buf_get_name(0)
            self.icon, self.icon_hl, _ = require("mini.icons").get("file", filename)

            if self.icon_hl then
                local hl = vim.api.nvim_get_hl(0, { name = self.icon_hl })
                self.icon_color = hl.fg and string.format("#%06x", hl.fg) or colors.text
            else
                self.icon_color = colors.text
            end
        end,
        provider = function(self)
            local ft = vim.bo.filetype
            return self.icon and (self.icon .. " " .. ft .. " ") or (ft .. " ")
        end,
        hl = function(self) return { fg = self.icon_color } end,
    }

    local CopilotStatus = {
        condition = function() return require("sidekick.status").get() ~= nil end,
        static = {
            icons = {
                Error = { " ", "diag_error" },
                Inactive = { " ", "gray" },
                Warning = { " ", "diag_warn" },
                Normal = { " ", "green" },
            },
        },
        provider = function(self)
            local status = require("sidekick.status").get()
            return status and vim.tbl_get(self.icons, status.kind, 1) or ""
        end,
        hl = function(self)
            local status = require("sidekick.status").get()
            if not status then return {} end

            if status.busy then return { fg = "diag_warn" } end

            local color = vim.tbl_get(self.icons, status.kind, 2)
            return { fg = color }
        end,
        update = { "User", pattern = "SidekickStatusUpdate" },
    }

    -- CLI Session
    local CLISession = {
        condition = function() return #require("sidekick.status").cli() > 0 end,
        provider = function()
            local status = require("sidekick.status").cli()
            return " " .. (#status > 1 and #status or "") .. " "
        end,
        hl = { fg = "cyan" },
        update = { "User", pattern = "SidekickCLIUpdate" },
    }

    -- Overseer
    local Overseer = {
        condition = function() return package.loaded["overseer"] ~= nil end,
        init = function(self)
            local tasks = require("overseer.task_list").list_tasks({ unique = true })
            local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
            self.running = tasks_by_status["RUNNING"] and #tasks_by_status["RUNNING"] or 0
            self.success = tasks_by_status["SUCCESS"] and #tasks_by_status["SUCCESS"] or 0
            self.failure = tasks_by_status["FAILURE"] and #tasks_by_status["FAILURE"] or 0
        end,
        {
            provider = function(self) return self.running > 0 and (" " .. self.running .. " ") end,
            hl = { fg = "yellow" },
        },
        {
            provider = function(self) return self.success > 0 and (" " .. self.success .. " ") end,
            hl = { fg = "green" },
        },
        {
            provider = function(self) return self.failure > 0 and (" " .. self.failure .. " ") end,
            hl = { fg = "red" },
        },
        update = { "User", pattern = "OverseerTaskUpdate" },
    }

    -- File Encoding
    local FileEncoding = {
        provider = function()
            local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
            local bomb = vim.bo.bomb and "[BOM]" or ""
            return enc:upper() .. bomb .. " "
        end,
        hl = { fg = "gray" },
    }

    -- File Format
    local FileFormat = {
        static = {
            symbols = {
                unix = "",
                dos = "",
                mac = "",
            },
        },
        provider = function(self) return self.symbols[vim.bo.fileformat] .. " " end,
        hl = { fg = "gray" },
    }

    -- Ruler
    local Ruler = {
        provider = "%7(%l/%3L%):%2c %P ",
        hl = { fg = "bright_fg", bold = true },
    }

    return {
        ViMode,
        Space,
        Git,
        Diagnostics,
        FileType,
        Align,
        CopilotStatus,
        CLISession,
        Overseer,
        FileEncoding,
        FileFormat,
        Ruler,
    }
end

return M
