local M = {}

local utils = require("heirline.utils")
local common = require("plugins.ui.heirline.components.common")
local tabline = require("plugins.ui.heirline.components.tabline")

function M.get()
    local BufferBlock = {
        init = function(self)
            -- File
            self.filepath = vim.api.nvim_buf_get_name(self.bufnr)

            -- Diagnostics
            local diagnostics = vim.diagnostic.get(self.bufnr)
            self.errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diagnostics)
            self.warnings = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diagnostics)
            self.has_errors = self.errors > 0
            self.has_warnings = self.warnings > 0
        end,
        hl = function(self) return self.is_active and { fg = "text", bg = "surface0", bold = true } or { fg = "subtext0", bg = "mantle" } end,
        on_click = {
            minwid = function(self) return self.bufnr end,
            callback = function(_, minwid, _, button)
                if button == "l" then vim.api.nvim_set_current_buf(minwid) end
            end,
            name = "heirline_buffer_switch_button",
        },
        tabline.Indicator,
        tabline.LeftPadding,
        common.FileIcon,
        tabline.FileName,
        tabline.FileFlags,
        tabline.RightPadding,
    }

    local BufferLine = utils.make_buflist({ BufferBlock }, {
        provider = " ",
        hl = { fg = "surface0" },
    }, {
        provider = " ",
        hl = { fg = "surface0" },
    })

    local TabBlock = {}

    local TabLine = utils.make_tablist(TabBlock)

    return {
        tabline.Offset,
        BufferLine,
        TabLine,
    }
end

return M
