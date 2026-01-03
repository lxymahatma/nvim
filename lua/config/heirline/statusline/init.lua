local icons = require("config.icons")

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
    require("config.heirline.statusline.section-a"),
    require("config.heirline.statusline.section-b"),
    require("config.heirline.statusline.section-c"),
    require("config.heirline.common.align"),
    require("config.heirline.statusline.section-x"),
    require("config.heirline.statusline.section-y"),
    require("config.heirline.statusline.section-z"),
}
