local UI = require("toolchain.ui.core")

local M = {}

---@param opts? {width?: integer, height?: integer}
---@return ToolchainUI
function M.open(opts) return UI(opts):open() end

return M
