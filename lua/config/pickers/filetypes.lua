local M = {}

---@class snacks.picker.filetypes.Config : snacks.picker.Config

---@class FiletypeInfo
---@field text string
---@field treesitter string[]
---@field lsp string[]
---@field formatters string[]
---@field linters string[]
---@field has_config boolean

---@type FiletypeInfo[]?
local cache = nil

---@return FiletypeInfo[]
function M.find()
    if cache then return cache end

    local parser = require("langs.lang-parser")
    cache = vim.tbl_map(function(ft)
        local cfg = parser.get_config_by_ft(ft)

        if not cfg then
            return {
                text = ft,
                treesitter = {},
                lsp = {},
                formatters = {},
                linters = {},
                has_config = false,
            }
        end

        return {
            text = ft,
            treesitter = cfg.treesitter,
            lsp = cfg.lsp or {},
            formatters = cfg.formatters or {},
            linters = cfg.linters or {},
            has_config = true,
        }
    end, vim.fn.getcompletion("", "filetype"))

    return cache
end

---@param item FiletypeInfo
---@param picker snacks.Picker
function M.format(item, picker)
    local align = Snacks.picker.util.align

    ---@cast picker.layout.wins.list.win integer
    local width = vim.api.nvim_win_get_width(picker.layout.wins.list.win) - 2

    local ft_icon, ft_hl = Snacks.util.icon(item.text, "filetype")

    local ts_icon = #item.treesitter > 0 and "" or " "
    local lsp_icon = #item.lsp > 0 and "" or " "
    local fmt_icon = #item.formatters > 0 and "󰉼" or " "
    local lint_icon = #item.linters > 0 and "󰁨" or " "

    local name_width = width - 10
    local icon_width = 2

    return {
        { align(ft_icon, icon_width),   ft_hl },
        {
            align(item.text, name_width, { truncate = true }),
            item.has_config and "" or "SnacksPickerDimmed",
        },
        { align(ts_icon, icon_width),   "SnacksPickerFtTreesitter" },
        { align(lsp_icon, icon_width),  "SnacksPickerFtLsp" },
        { align(fmt_icon, icon_width),  "SnacksPickerFtFormatter" },
        { align(lint_icon, icon_width), "SnacksPickerFtLinter" },
    }
end

---@param ctx snacks.picker.preview.ctx
function M.preview(ctx)
    local item = ctx.item
    local lines = {}

    lines[#lines + 1] = "# " .. item.text
    lines[#lines + 1] = ""

    if not item.has_config then
        lines[#lines + 1] = "**Status**: ✗ Not configured"
        lines[#lines + 1] = ""
        ctx.preview:set_lines(lines)
        ctx.preview:highlight({ ft = "markdown" })
        return
    end

    lines[#lines + 1] = "**Status**: ✓ Configured"
    lines[#lines + 1] = ""

    -- Treesitter
    lines[#lines + 1] = "##  Treesitter"
    for _, parser in ipairs(item.treesitter) do
        lines[#lines + 1] = "- " .. parser
    end
    lines[#lines + 1] = ""

    -- LSP
    if #item.lsp > 0 then
        lines[#lines + 1] = "##  LSP Servers"
        for _, server in ipairs(item.lsp) do
            lines[#lines + 1] = "- " .. server
        end
        lines[#lines + 1] = ""
    end

    -- Formatters
    if #item.formatters > 0 then
        lines[#lines + 1] = "## 󰉼 Formatters"
        for _, formatter in ipairs(item.formatters) do
            lines[#lines + 1] = "- " .. formatter
        end
        lines[#lines + 1] = ""
    end

    -- Linters
    if #item.linters > 0 then
        lines[#lines + 1] = "## 󰁨 Linters"
        for _, linter in ipairs(item.linters) do
            lines[#lines + 1] = "- " .. linter
        end
        lines[#lines + 1] = ""
    end

    ctx.preview:set_lines(lines)
    ctx.preview:highlight({ ft = "markdown" })
end

return M
