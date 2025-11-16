return {
    condition = function() return #require("sidekick.status").cli() > 0 end,
    init = function(self) self.status = require("sidekick.status").cli() end,
    {
        provider = function(self) return "  " .. (#self.status > 1 and #self.status or "") end,
        hl = { fg = Snacks.util.color("Special") },
    },
    update = { "User", pattern = { "SidekickCliAttach", "SidekickCliDetach" } },
}
