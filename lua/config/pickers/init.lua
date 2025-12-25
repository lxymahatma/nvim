local M = {}

function M.setup()
    local filetypes_picker = require("config.pickers.filetypes")
    Snacks.picker.sources.filetypes = {
        title = "Filetypes",
        layout = "default",
        sort = { fields = { "has_config", "text" } },
        matcher = { sort_empty = true },
        finder = filetypes_picker.find,
        format = filetypes_picker.format,
        preview = filetypes_picker.preview,

        ---@param picker snacks.Picker
        ---@param item FiletypeInfo
        confirm = function(picker, item)
            picker:close()
            vim.bo.filetype = item.text
        end,
    }
end

return M
