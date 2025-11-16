local M = {}

local icons = require("config.icons")
local utils = require("heirline.utils")
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

    local left_section_a = {
        components.vimode,
        LeftSectionSepA,
    }

    local left_section_b = {
        components.git,
        LeftSectionSepB,
    }

    local left_section_c = {
        utils.insert(components.diagnostics, LeftComponentSep),
        components.file_type,
    }

    local right_section_x = {
        components.sidekick_copilot,
        utils.insert(components.sidekick_cli, RightComponentSep),
        utils.insert(components.file_encoding, RightComponentSep),
        components.file_format,
    }

    local right_section_y = {
        RightSectionSepY,
        components.progress,
    }

    local right_section_z = {
        RightSectionSepZ,
        components.location,
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
        left_section_a,
        left_section_b,
        left_section_c,
        Align,
        right_section_x,
        right_section_y,
        right_section_z,
    }
end

return M
