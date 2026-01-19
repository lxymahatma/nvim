local ActiveMark = require("config.heirline.tabline.buffer.active-mark")
local Padding = require("config.heirline.tabline.buffer.padding")
local Filename = require("config.heirline.tabline.buffer.filename")
local ModifiedMark = require("config.heirline.tabline.buffer.modified-mark")

return {
    static = {
        buffer_min_width = 20,
        filename_max_length = 18,
    },
    init = function(self)
        self.filepath = vim.api.nvim_buf_get_name(self.bufnr)
        self.filename = self.filepath == "" and "[No Name]" or vim.fn.fnamemodify(self.filepath, ":t")
        if #self.filename > self.filename_max_length then self.filename = self.filename:sub(1, self.filename_max_length) .. "..." end

        local diagnostics = vim.diagnostic.get(self.bufnr)
        self.errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diagnostics)
        self.warnings = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diagnostics)
        self.has_errors = self.errors > 0
        self.has_warnings = self.warnings > 0

        local current_width = 4 + #self.filename
        local padding_needed = math.max(0, self.buffer_min_width - current_width) --[[@as integer]]
        self.buffer_padding = math.floor(padding_needed / 2)

        self.modified = vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    hl = function(self) return self.is_active and { fg = "text", bg = "surface0", bold = true } or { fg = "subtext0", bg = "mantle" } end,
    on_click = {
        minwid = function(self) return self.bufnr end,
        callback = function(_, minwid, _, button)
            if button == "l" then vim.api.nvim_set_current_buf(minwid) end
        end,
        name = "heirline_buffer_switch_button",
    },
    ActiveMark,
    Padding,
    Filename,
    ModifiedMark,
    Padding,
}
