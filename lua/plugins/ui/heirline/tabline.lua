local M = {}

local common = require("plugins.ui.heirline.components.common")
local utils = require("heirline.utils")

function M.get()
    local TablineFileName = {
        provider = function(self)
            local filename = self.filename
            filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
            return filename
        end,
        hl = function(self) return { bold = self.is_active, italic = true } end,
    }

    local TablineFileFlags = {
        condition = function(self) return vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) end,
        provider = " ●",
        hl = { fg = "orange" },
    }

    local TablineFileNameBlock = {
        init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
        hl = function(self)
            if self.is_active then
                return { bg = "surface0", fg = "text", bold = true }
            else
                return { bg = "mantle", fg = "subtext0" }
            end
        end,
        common.Space,
        common.FileIcon,
        TablineFileName,
        common.TablineDiagnostics,
        TablineFileFlags,
        common.Space,
    }

    local TablineBufferBlock = utils.surround({ "", "" }, function(self)
        if self.is_active then
            return "surface0"
        else
            return "mantle"
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
