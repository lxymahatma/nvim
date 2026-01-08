local core = require("toolchain.ui.core")

local M = {}

---@param opts? {width?: integer, height?: integer}
---@return ToolchainUI
function M.open(opts) return core.new(opts):open() end

return M
