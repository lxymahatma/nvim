local common = require("heirline.components.common")

return {
    common.fileicon,
    {
        provider = function() return vim.bo.filetype end,
        hl = { fg = "text" },
    },
}
