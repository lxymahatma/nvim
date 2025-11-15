local M = {}

local icons = require("config.icons")

local common = require("plugins.ui.heirline.components.common")
local statusline = require("plugins.ui.heirline.components.statusline")

function M.get()
    local Align = { provider = "%=" }

    local LeftSectionA = {
        statusline.ViMode,
        statusline.LeftSectionSepA,
    }

    local LeftSectionB = {
        statusline.Git,
        statusline.LeftSectionSepB,
    }

    local LeftSectionC = {
        statusline.Diagnostics,
        common.FileIcon,
        statusline.FileType,
    }

    local RightSectionX = {
        statusline.SideKickCopilot,
        statusline.SideKickCli,
        statusline.FileEncoding,
        statusline.FileFormat,
    }

    local RightSectionY = {
        statusline.RightSectionSepY,
        statusline.Progress,
    }

    local RightSectionZ = {
        statusline.RightSectionSepZ,
        statusline.Location,
    }

    return {
        init = function(self)
            -- Mode
            self.mode = vim.fn.mode(1)
            self.mode_key = self.mode:sub(1, 1)

            -- File
            self.filename = vim.api.nvim_buf_get_name(0)
            self.line = vim.fn.line(".")
            self.charcol = vim.fn.charcol(".")
            self.total = vim.fn.line("$")
        end,
        static = {
            mode_colors = {
                n = "blue",
                i = "green",
                v = "mauve",
                V = "mauve",
                ["\22"] = "mauve",
                c = "peach",
                s = "mauve",
                S = "mauve",
                ["\19"] = "mauve",
                R = "red",
                r = "red",
                ["!"] = "red",
                t = "green",
            },

            left_section_sep = icons.LeftSectionSep .. " ",
            left_component_sep = icons.LeftComponentSep .. " ",
            right_section_sep = " " .. icons.RightSectionSep,
            right_component_sep = " " .. icons.RightComponentSep,
        },
        LeftSectionA,
        LeftSectionB,
        LeftSectionC,
        Align,
        RightSectionX,
        RightSectionY,
        RightSectionZ,
    }
end

return M
