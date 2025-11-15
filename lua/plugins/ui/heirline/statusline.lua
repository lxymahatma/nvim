local M = {}

local components = require("plugins.ui.heirline.components")
local icons = require("config.icons")

function M.setup()
    local Align = { provider = "%=" }

    local FileIconBlock = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
        components.FileIcon,
    }

    local LeftSectionA = {
        components.ViMode,
        components.LeftSectionSepX,
    }

    local LeftSectionB = {
        components.StatusLineGit,
        components.LeftSectionSepY,
    }

    local LeftSectionC = {
        components.StatusLineDiagnostics,
        FileIconBlock,
        components.FileType,
    }

    local RightSectionX = {
        components.SideKickCopilot,
        components.SideKickCli,
        components.FileEncoding,
        components.FileFormat,
    }

    local RightSectionY = {
        components.RightSectionSepY,
        components.Progress,
    }

    local RightSectionZ = {
        components.RightSectionSepZ,
        components.Location,
    }

    return {
        init = function(self)
            -- Mode
            self.mode = vim.fn.mode(1)
            self.mode_key = self.mode:sub(1, 1)

            -- File
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
