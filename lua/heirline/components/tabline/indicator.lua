return {
    static = {
        indicator = "▎ ",
    },
    provider = function(self) return self.is_active and self.indicator or " " end,
    hl = { fg = "orange" },
}
