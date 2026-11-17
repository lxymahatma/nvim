local M = {}

M.branch = " "

M.diagnostics = {
  Error = " ",
  Warn = " ",
  Info = " ",
  Hint = " ",
}

M.fileformat = {
  unix = "",
  dos = "",
  mac = "",
}

M.bufferline = {
  active = "▎",
  modified = "●",
  separator = "│",
  trunc_left = " ",
  trunc_right = " ",
}

M.LeftSectionSep = ""
M.RightSectionSep = ""
M.LeftComponentSep = ""
M.RightComponentSep = ""

M.toolchain = {
  enabled = "",
  disabled = "",
  blocked = "",
  default = "★",
  tab_active = "●",
  tab_inactive = "○",
}

M.dap = {
  Stopped = "󰁕 ",
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = " ",
  LogPoint = ".>",
}

return M
