local M = {}

local common = require("plugins.ui.heirline.components.common")

M.Indicator = {
    static = {
        indicator = "▎ ",
    },
    provider = function(self) return self.is_active and self.indicator or " " end,
    hl = { fg = "orange" },
}

M.BufferPadding = {
    provider = function(self) return string.rep(" ", self.buffer_padding) end,
    hl = function(self) return self.is_active and { bg = "surface0" } or { bg = "mantle" } end,
}

M.FileName = {
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

M.FileFlags = {
    provider = function(self)
        if vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) then
            return " ●"
        else
            return "  "
        end
    end,
    hl = { fg = "orange" },
}

M.Offset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        ---@cast win integer

        self.winid = win
        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "snacks_layout_box"
    end,
    provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid)) end,
}

return M
