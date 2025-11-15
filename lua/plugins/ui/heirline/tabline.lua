local M = {}

local utils = require("heirline.utils")
local common = require("plugins.ui.heirline.components.common")
local tabline = require("plugins.ui.heirline.components.tabline")

function M.get()
    local BufferBlock = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
        hl = function(self) return self.is_active and { fg = "text", bg = "surface0", bold = true } or { fg = "subtext0", bg = "mantle" } end,
        on_click = {
            minwid = function(self) return self.bufnr end,
            callback = function(_, minwid, _, button)
                if button == "l" then vim.api.nvim_set_current_buf(minwid) end
            end,
            name = "heirline_winbar_switch_button",
        },
        tabline.Indicator,
        tabline.BufferPadding,
        common.FileIcon,
        tabline.FileName,
        tabline.Diagnostics,
        tabline.FileFlags,
        tabline.BufferPadding,
    }

    local BufferLine = utils.make_buflist({ BufferBlock }, {
        provider = " ",
        hl = { fg = "surface0" },
    }, {
        provider = " ",
        hl = { fg = "surface0" },
    })

    return {
        tabline.Offset,
        BufferLine,
    }
end

return M
