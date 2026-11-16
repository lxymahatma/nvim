local icons = require("config.icons")

local Encoding = {
  {
    provider = function()
      local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
      local bomb = vim.bo.bomb and "[BOM]" or ""
      return " " .. enc:upper() .. bomb
    end,
    hl = { fg = "text" },
  },
  {
    provider = function(self) return self.sep.right_component end,
    hl = { fg = "text" },
  },
}

local FileFormat = {
  static = {
    symbols = {
      unix = icons.fileformat.unix,
      dos = icons.fileformat.dos,
      mac = icons.fileformat.mac,
    },
  },
  provider = function(self) return " " .. self.symbols[vim.bo.fileformat] end,
  hl = { fg = "text" },
}

return {
  Encoding,
  FileFormat,
}
