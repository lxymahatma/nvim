return {
    {
        provider = function(self) return self.sep.right_section end,
        hl = function(self)
            return { fg = self.mode_colors[self.mode_key], bg = "surface0" }
        end,
    },
    {
        provider = function(self) return string.format("%4d:%-3d", self.line, self.charcol) end,
        hl = function(self)
            return { fg = "surface0", bg = self.mode_colors[self.mode_key], bold = true }
        end,
    },
}
