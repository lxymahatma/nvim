---@type FiletypeInfo[]?
local cache = nil

---@class FiletypeInfo
---@field text string
---@field treesitter string[]
---@field lsp string[]
---@field formatters string[]
---@field linters string[]
---@field has_config boolean

---@return FiletypeInfo[]
local function get_filetype_infos()
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

---@type snacks.picker.Config
return {
    title = "Filetypes",
    layout = "vscode",
    sort = { fields = { "has_config", "text" } },
    matcher = { sort_empty = true, frecency = true },
    finder = get_filetype_infos,

    ---@param item snacks.picker.Item
    ---@param picker snacks.Picker
    format = function(item, picker)
        local align = Snacks.picker.util.align

        ---@cast picker.layout.wins.list.win integer
        local width = vim.api.nvim_win_get_width(picker.layout.wins.list.win) - 2

        local icon, hl = Snacks.util.icon(item.text, "filetype")

        local ts_icon = #item.treesitter > 0 and "" or " "
        local lsp_icon = #item.lsp > 0 and "" or " "
        local fmt_icon = #item.formatters > 0 and "󰉼" or " "
        local lint_icon = #item.linters > 0 and "󰁨" or " "

        local name_width = math.floor(width * 0.5)
        local icon_width = 2

        return {
            { align(icon, 2),               hl },
            {
                align(item.text, name_width, { truncate = true }),
                item.has_config and "" or "SnacksPickerDimmed",
            },
            { align(ts_icon, icon_width),   "DiagnosticOk" },
            { align(lsp_icon, icon_width),  "DiagnosticOk" },
            { align(fmt_icon, icon_width),  "DiagnosticOk" },
            { align(lint_icon, icon_width), "DiagnosticOk" },
        }
    end,

    ---@param picker snacks.Picker
    ---@param item FiletypeInfo
    confirm = function(picker, item)
        picker:close()
        vim.bo.filetype = item.text
    end,
}
