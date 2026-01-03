local FileIcon = require("config.heirline.common.fileicon")

local function get_fg(self)
    if self.has_errors then return "red" end
    if self.has_warnings then return "yellow" end
    if self.is_active then return "text" end
    return "subtext0"
end

return {
    FileIcon,
    {
        provider = function(self) return self.filename end,
        hl = function(self)
            return {
                fg = get_fg(self),
                bold = self.is_active,
                italic = self.is_active,
            }
        end,
    },
}
