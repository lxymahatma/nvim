local icons = require("config.icons")

local Align = require("config.heirline.common.align")
local SectionA = require("config.heirline.statusline.section-a")
local SectionB = require("config.heirline.statusline.section-b")
local SectionC = require("config.heirline.statusline.section-c")
local SectionX = require("config.heirline.statusline.section-x")
local SectionY = require("config.heirline.statusline.section-y")
local SectionZ = require("config.heirline.statusline.section-z")

return {
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
        sep = {
            left_section = icons.LeftSectionSep .. " ",
            left_component = icons.LeftComponentSep .. " ",
            right_section = " " .. icons.RightSectionSep,
            right_component = " " .. icons.RightComponentSep,
        },
    },
    init = function(self)
        self.mode = vim.fn.mode(1)
        self.mode_key = self.mode:sub(1, 1)
        self.filepath = vim.api.nvim_buf_get_name(0)
        self.line = vim.fn.line(".")
        self.charcol = vim.fn.charcol(".")
        self.total = vim.fn.line("$")
    end,
    SectionA,
    SectionB,
    SectionC,
    Align,
    SectionX,
    SectionY,
    SectionZ,
}
