local M = {}

local icons = require("config.icons")
local utils = require("helpers.heirline")
local common = require("heirline.components.common")
local statusline = require("heirline.components.statusline")

local function make_section_sep(side, use_mode_color)
    return {
        provider = function(self) return self[side .. "_section_sep"] end,
        hl = use_mode_color and function(self)
            return {
                fg = self.mode_colors[self.mode_key],
                bg = "surface0",
            }
        end or { fg = "surface0", bg = "mantle" },
    }
end

local function make_component_sep(side)
    return {
        provider = function(self) return self[side .. "_component_sep"] end,
        hl = { fg = "text" },
    }
end

function M.get()
    local LeftSectionSepA = make_section_sep("left", true)
    local LeftSectionSepB = make_section_sep("left", false)
    local RightSectionSepY = make_section_sep("right", false)
    local RightSectionSepZ = make_section_sep("right", true)
    local LeftComponentSep = make_component_sep("left")
    local RightComponentSep = make_component_sep("right")

    local LeftSectionA = { statusline.Vimode }
    local LeftSectionB = { statusline.Git }
    local LeftSectionC = {
        utils.insert_last(statusline.Diagnostics, LeftComponentSep),
        statusline.FileType,
    }

    local RightSectionX = {
        statusline.SidekickCopilot,
        utils.insert_last(statusline.SidekickCli, RightComponentSep),
        utils.insert_last(statusline.Encoding, RightComponentSep),
        statusline.FileFormat,
    }

    local RightSectionY = { statusline.Progress }
    local RightSectionZ = { statusline.Location }

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
        common.Align,
        RightSectionX,
        utils.insert_first(RightSectionY, RightSectionSepY),
        utils.insert_first(RightSectionZ, RightSectionSepZ),
    }
end

return M
