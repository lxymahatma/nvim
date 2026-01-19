local icons = require("config.icons").bufferline
local utils = require("heirline.utils")

local Align = require("config.heirline.common.align")
local Offset = require("config.heirline.tabline.offset")
local BufferBlock = require("config.heirline.tabline.buffer")
local TabBlock = require("config.heirline.tabline.tab")

local BufferLine = utils.make_buflist({ BufferBlock }, {
    provider = icons.trunc_left,
    hl = { fg = "text" },
}, {
    provider = icons.trunc_right,
    hl = { fg = "text" },
}, function() return require("tabscope").get_buflist() end, false)

local TabLine = utils.make_tablist(TabBlock)

return {
    Offset,
    BufferLine,
    Align,
    TabLine,
}
