local common = require("heirline.components.common")

return {
    common.FileIcon,
    {
        provider = function() return vim.bo.filetype end,
        hl = { fg = "text" },
    },
}
