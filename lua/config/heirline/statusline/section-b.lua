local icons = require("config.icons")

return {
    {
        condition = function(self) return vim.b.gitsigns_status_dict or self.last_branch end,
        hl = { bg = "surface0" },
        init = function(self)
            local dict = vim.b.gitsigns_status_dict
            if dict then
                self.status_dict = dict
                self.last_branch = dict.head
                self.has_changes = vim.b.gitsigns_status ~= ""
            else
                self.status_dict = nil
                self.has_changes = false
            end
        end,
        {
            provider = function(self) return icons.branch .. self.last_branch .. " " end,
            hl = function(self) return { fg = self.mode_colors[self.mode_key] } end,
        },
        {
            condition = function(self) return self.has_changes end,
            {
                provider = function(self) return self.sep.left_component end,
                hl = { fg = "text" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.added or 0
                    return count > 0 and ("+" .. count .. " ")
                end,
                hl = "GitSignsAdd",
            },
            {
                provider = function(self)
                    local count = self.status_dict.changed or 0
                    return count > 0 and ("~" .. count .. " ")
                end,
                hl = "GitSignsChange",
            },
            {
                provider = function(self)
                    local count = self.status_dict.removed or 0
                    return count > 0 and ("-" .. count .. " ")
                end,
                hl = "GitSignsDelete",
            },
        },
    },
    {
        provider = function(self) return self.sep.left_section end,
        hl = { fg = "surface0", bg = "mantle" },
    },
}
