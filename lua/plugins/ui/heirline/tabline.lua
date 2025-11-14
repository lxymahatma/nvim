local M = {}

local components = require("plugins.ui.heirline.components")
local utils = require("heirline.utils")

function M.setup(colors)
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
                return { bg = colors.surface0, fg = colors.text, bold = true }
            else
                return { bg = colors.mantle, fg = colors.subtext0 }
            end
        end,
        components.Space,
        components.FileIcon,
        TablineFileName,
        components.TablineDiagnostics,
        TablineFileFlags,
        components.Space,
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
