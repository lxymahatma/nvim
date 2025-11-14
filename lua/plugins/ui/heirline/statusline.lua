local M = {}

local components = require("plugins.ui.heirline.components")
local conditions = require("heirline.conditions")

function M.setup(colors)
    local Align = { provider = "%=" }

    local Git = {
        condition = conditions.is_git_repo,
        init = function(self) self.status_dict = vim.b.gitsigns_status_dict end,
        hl = { fg = "orange" },
        {
            provider = function(self) return self.status_dict.head .. " " end,
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

    local FileIconBlock = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
        components.FileIcon,
    }

    local Ruler = {
        init = function(self)
            self.line = vim.fn.line(".")
            self.charcol = vim.fn.charcol(".")
            self.total = vim.fn.line("$")
        end,
        components.Progress,
        components.Space,
        components.Location,
    }

    return {
        components.ViMode,
        components.Space,
        Git,
        components.StatusLineDiagnostics,
        FileIconBlock,
        components.FileType,
        Align,
        components.SideKickCopilot,
        components.SideKickCli,
        components.Space,
        components.FileEncoding,
        components.FileFormat,
        Ruler,
    }
end

return M
