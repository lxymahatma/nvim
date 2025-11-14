local M = {}

function M.setup(colors)
    local utils = require("heirline.utils")

    local FileIcon = {
        init = function(self)
            local filename = self.filename
            self.icon, self.icon_hl, _ = require("mini.icons").get("file", filename)

            if self.icon_hl then
                local hl = vim.api.nvim_get_hl(0, { name = self.icon_hl })
                self.icon_color = hl.fg and string.format("#%06x", hl.fg) or colors.text
            else
                self.icon_color = colors.text
            end
        end,
        provider = function(self) return self.icon and (self.icon .. " ") end,
        hl = function(self) return { fg = self.icon_color } end,
    }

    local TablineDiagnostics = {
        condition = function(self) return #vim.diagnostic.get(self.bufnr) > 0 end,
        init = function(self)
            local diagnostics = vim.diagnostic.get(self.bufnr)
            self.errors = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.ERROR end, diagnostics)
            self.warnings = #vim.tbl_filter(function(d) return d.severity == vim.diagnostic.severity.WARN end, diagnostics)
        end,
        update = { "DiagnosticChanged", "BufEnter" },
        {
            provider = function(self) return self.errors > 0 and (" " .. self.errors) or "" end,
            hl = { fg = "diag_error" },
        },
        {
            provider = function(self) return self.warnings > 0 and (" " .. self.warnings) or "" end,
            hl = { fg = "diag_warn" },
        },
    }

    local TablineFileName = {
        provider = function(self)
            local filename = self.filename
            filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
            return filename
        end,
        hl = function(self) return { bold = self.is_active, italic = true } end,
    }

    local TablineFileFlags = {
        {
            condition = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
            provider = " ●",
            hl = { fg = "green" },
        },
    }

    local TablineFileNameBlock = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
        hl = function(self)
            if self.is_active then
                return { bg = colors.surface0, fg = colors.text, bold = true }
            else
                return { bg = colors.mantle, fg = colors.subtext0 }
            end
        end,
        on_click = {
            callback = function(_, minwid, _, button)
                if button == "m" then
                    vim.schedule(function()
                        Snacks.bufdelete(minwid)
                        vim.cmd.redrawtabline()
                    end)
                else
                    vim.api.nvim_win_set_buf(0, minwid)
                end
            end,
            minwid = function(self) return self.bufnr end,
            name = "heirline_tabline_buffer_callback",
        },
        { provider = " " },
        FileIcon,
        TablineFileName,
        TablineDiagnostics,
        TablineFileFlags,
        { provider = " " },
    }

    local TablineBufferBlock = utils.surround({ "", "" }, function(self)
        if self.is_active then
            return colors.surface0
        else
            return colors.mantle
        end
    end, { TablineFileNameBlock })

    local TabLineOffset = {
        condition = function(self)
            local win = vim.api.nvim_tabpage_list_wins(0)[1]
            ---@cast win integer

            self.winid = win
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "snacks_layout_box"
        end,
        provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid)) end,
    }

    local BufferLine = utils.make_buflist(TablineBufferBlock, {
        provider = "",
        hl = { fg = "gray" },
    }, {
        provider = "",
        hl = { fg = "gray" },
    })

    return { TabLineOffset, BufferLine }
end

return M
