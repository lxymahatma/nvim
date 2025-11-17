local M = {}

local helpers = require("helpers.buffer")
local utils = require("heirline.utils")
local common = require("heirline.components.common")
local tabline = require("heirline.components.tabline")

function M.get()
    local BufferBlock = {
        static = {
            buffer_min_width = 20,
            filename_max_length = 18,
        },
        init = function(self)
            -- File
            self.filepath = vim.api.nvim_buf_get_name(self.bufnr)
            self.filename = self.filepath == "" and "[No Name]" or vim.fn.fnamemodify(self.filepath, ":t")
            if #self.filename > self.filename_max_length then self.filename = self.filename:sub(1, self.filename_max_length) .. "..." end

            -- Diagnostics
            local diagnostics = vim.diagnostic.get(self.bufnr)
            self.errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diagnostics)
            self.warnings = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diagnostics)
            self.has_errors = self.errors > 0
            self.has_warnings = self.warnings > 0

            -- Padding
            local current_width = 6 + #self.filename
            local padding_needed = math.max(0, self.buffer_min_width - current_width) --[[@type number]]
            self.buffer_padding = math.floor(padding_needed / 2)
        end,
        hl = function(self) return self.is_active and { fg = "text", bg = "surface0", bold = true } or { fg = "subtext0", bg = "mantle" } end,
        on_click = {
            minwid = function(self) return self.bufnr end,
            callback = function(_, minwid, _, button)
                if button == "l" then vim.api.nvim_set_current_buf(minwid) end
            end,
            name = "heirline_buffer_switch_button",
        },
        tabline.ActiveMark,
        tabline.BufferPadding,
        tabline.FileName,
        tabline.ModifiedMark,
        tabline.BufferPadding,
    }

    local BufferLine = utils.make_buflist({ BufferBlock }, {
        provider = " ",
        hl = { fg = "text" },
    }, {
        provider = " ",
        hl = { fg = "text" },
    })

    local TabBlock = {
        condition = function() return vim.fn.tabpagenr("$") > 1 end,
        init = function(self) self.is_active = self.tabnr == vim.fn.tabpagenr() end,
        hl = function(self) return self.is_active and { fg = "red", bg = "surface0", bold = true } or { fg = "subtext0", bg = "mantle" } end,
        on_click = {
            minwid = function(self) return self.tabpage end,
            callback = function(_, minwid, _, button)
                if button == "l" then vim.api.nvim_set_current_tabpage(minwid) end
            end,
            name = "heirline_tab_switch_button",
        },
        provider = function(self) return " " .. self.tabnr .. " " end,
    }

    local TabLine = utils.make_tablist(TabBlock)

    return {
        tabline.Offset,
        BufferLine,
        common.Align,
        TabLine,
    }
end

return M
