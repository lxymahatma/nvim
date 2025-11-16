local common = require("heirline.components.common")

return {
    common.file_icon,
    {
        provider = function() return vim.bo.filetype end,
        hl = { fg = "text" },
    },
}
