local M = {}

local icons = require("config.icons")
local utils = require("helpers.heirline")
local components = require("heirline.components.statusline")

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
        components.Vimode,
    }

    local LeftSectionB = {
        components.Git,
    }

    local LeftSectionC = {
        utils.insert_last(components.Diagnostics, LeftComponentSep),
        components.FileType,
    }

    local RightSectionX = {
        components.SidekickCopilot,
        utils.insert_last(components.SidekickCli, RightComponentSep),
        utils.insert_last(components.Encoding, RightComponentSep),
        components.FileFormat,
    }

    local RightSectionY = {
        components.Progress,
    }

    local RightSectionZ = {
        components.Location,
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
        utils.insert_last(LeftSectionA, LeftSectionSepA),
        utils.insert_last(LeftSectionB, LeftSectionSepB),
        LeftSectionC,
        Align,
        RightSectionX,
        utils.insert_first(RightSectionY, RightSectionSepY),
        utils.insert_first(RightSectionZ, RightSectionSepZ),
    }
end

return M
