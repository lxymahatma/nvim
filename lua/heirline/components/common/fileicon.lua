return {
    init = function(self)
        self.icon, self.icon_hl = require("mini.icons").get("file", self.filepath)
    end,
    provider = function(self) return self.icon and (self.icon .. " ") end,
    hl = function(self) return self.icon_hl end,
}
