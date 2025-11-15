local M = {}

local icons = require("config.icons")
local utils = require("heirline.utils")
local statusline = require("plugins.ui.heirline.components.statusline")

function M.get()
    local Align = { provider = "%=" }

    local LeftSectionSepA = {
        provider = function(self) return self.left_section_sep end,
        hl = function(self)
            return {
                fg = self.mode_colors[self.mode_key],
                bg = "surface0",
            }
        end,
    }

    local LeftSectionSepB = {
        provider = function(self) return self.left_section_sep end,
        hl = {
            fg = "surface0",
            bg = "mantle",
        },
    }

    local RightSectionSepY = {
        provider = function(self) return self.right_section_sep end,
        hl = {
            fg = "surface0",
            bg = "mantle",
        },
    }

    local RightSectionSepZ = {
        provider = function(self) return self.right_section_sep end,
        hl = function(self)
            return {
                fg = self.mode_colors[self.mode_key],
                bg = "surface0",
            }
        end,
    }

    local LeftComponentSep = {
        provider = function(self) return self.left_component_sep end,
        hl = { fg = "text" },
    }

    local RightComponentSep = {
        provider = function(self) return self.right_component_sep end,
        hl = { fg = "text" },
    }

    local LeftSectionA = {
        statusline.ViMode,
        LeftSectionSepA,
    }

    local LeftSectionB = {
        statusline.Git,
        LeftSectionSepB,
    }

    local LeftSectionC = {
        utils.insert(statusline.Diagnostics, LeftComponentSep),
        statusline.FileType,
    }

    local RightSectionX = {
        statusline.SideKickCopilot,
        utils.insert(statusline.SideKickCli, RightComponentSep),
        utils.insert(statusline.FileEncoding, RightComponentSep),
        statusline.FileFormat,
    }

    local RightSectionY = {
        RightSectionSepY,
        statusline.Progress,
    }

    local RightSectionZ = {
        RightSectionSepZ,
        statusline.Location,
    }

    return {
        init = function(self)
            -- Mode
            self.mode = vim.fn.mode(1)
            self.mode_key = self.mode:sub(1, 1)

            -- File
            self.filepath = vim.api.nvim_buf_get_name(0)
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
