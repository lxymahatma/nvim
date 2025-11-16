return {
    provider = function(self)
        if self.line == 1 then
            return "Top"
        elseif self.line == self.total then
            return "Bot"
        else
            local percent = math.floor((self.line / self.total) * 100)
            return string.format("%3d%%%%", percent)
        end
    end,
    hl = function(self)
        return {
            fg = self.mode_colors[self.mode_key],
            bg = "surface0",
        }
    end,
}
