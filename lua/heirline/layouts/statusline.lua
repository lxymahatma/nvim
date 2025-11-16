local M = {}

local icons = require("config.icons")
local utils = require("helpers.heirline")
local common = require("heirline.components.common")
local components = require("heirline.components.statusline")

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

    local LeftSectionA = { components.Vimode }
    local LeftSectionB = { components.Git }
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

    local RightSectionY = { components.Progress }
    local RightSectionZ = { components.Location }

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
