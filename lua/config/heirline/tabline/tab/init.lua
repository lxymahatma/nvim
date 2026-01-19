return {
    condition = function() return #vim.api.nvim_list_tabpages() > 1 end,
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
