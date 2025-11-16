local common = require("heirline.components.common")

return {
    common.FileIcon,
    {
        provider = function(self) return self.filename end,
        hl = function(self)
            return {
                fg = self.has_errors and "diag_error" or self.has_warnings and "diag_warn" or self.is_active and "text" or "subtext0",
                bold = self.is_active,
                italic = self.is_active,
            }
        end,
    },
}
