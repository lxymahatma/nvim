local table_helper = require("helpers.table")

local M = {}

---@type string[]?
local filetypes = nil

---@return FiletypeInfo[]
function M.find()
  filetypes = filetypes or vim.fn.getcompletion("", "filetype")

  local installed = {}
  for _, path in ipairs(vim.api.nvim_get_runtime_file("parser/*", true)) do
    installed[vim.fn.fnamemodify(path, ":t:r")] = true
  end

  ---@type table<string, table<string, boolean>>
  local clients = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    for buf in pairs(client.attached_buffers) do
      local ft = vim.bo[buf].filetype
      clients[ft] = clients[ft] or {}
      clients[ft][client.name] = true
    end
  end

  local formatters_by_ft = require("conform").formatters_by_ft
  local linters_by_ft = require("lint").linters_by_ft
  local dap_configurations = require("dap").configurations

  return vim.tbl_map(function(ft)
    local lang = vim.treesitter.language.get_lang(ft)
    local treesitter = installed[lang] and { lang } or {}

    local running = vim.tbl_keys(clients[ft] or {})
    local configs = vim.lsp.get_configs({ enabled = true, filetype = ft })
    local enabled = vim.tbl_map(function(config) return config.name end, configs)
    local lsp = vim.list.unique(table_helper.list_merge(enabled, running))
    table.sort(lsp)

    local formatters = formatters_by_ft[ft] or {}
    local linters = linters_by_ft[ft] or {}
    local dap = dap_configurations[ft] or {}

    return {
      text = ft,
      treesitter = treesitter,
      lsp = lsp,
      running = running,
      formatters = formatters,
      linters = linters,
      dap = dap,
      active = #treesitter > 0 or #lsp > 0 or #formatters > 0 or #linters > 0 or #dap > 0,
    }
  end, filetypes)
end

---@param item FiletypeInfo
---@param picker snacks.Picker
---@return snacks.picker.Highlight[]
function M.format(item, picker)
  local align = Snacks.picker.util.align

  ---@cast picker.layout.wins.list.win integer
  local width = vim.api.nvim_win_get_width(picker.layout.wins.list.win) - 2

  local ft_icon, ft_hl = Snacks.util.icon(item.text, "filetype")

  local ts_icon = #item.treesitter > 0 and "" or " "
  local lsp_icon = #item.lsp > 0 and "" or " "
  local fmt_icon = #item.formatters > 0 and "󰉼" or " "
  local lint_icon = #item.linters > 0 and "󰁨" or " "
  local dap_icon = #item.dap > 0 and "󰃤" or " "

  local lsp_running = #item.running == #item.lsp

  local name_width = width - 12
  local icon_width = 2

  return {
    { align(ft_icon, icon_width), ft_hl },
    {
      align(item.text, name_width, { truncate = true }),
      item.active and "" or "SnacksPickerDimmed",
    },
    { align(ts_icon, icon_width), "SnacksPickerFtTreesitter" },
    { align(lsp_icon, icon_width), lsp_running and "SnacksPickerFtLsp" or "SnacksPickerDimmed" },
    { align(fmt_icon, icon_width), "SnacksPickerFtFormatter" },
    { align(lint_icon, icon_width), "SnacksPickerFtLinter" },
    { align(dap_icon, icon_width), "SnacksPickerFtDap" },
  }
end

---@param ctx snacks.picker.preview.ctx
function M.preview(ctx)
  local item = ctx.item
  local lines = {}

  lines[#lines + 1] = "# " .. item.text
  lines[#lines + 1] = ""

  -- Treesitter
  if #item.treesitter > 0 then
    lines[#lines + 1] = "##  Treesitter"
    for _, parser in ipairs(item.treesitter) do
      lines[#lines + 1] = "- " .. parser
    end
    lines[#lines + 1] = ""
  end

  -- LSP
  if #item.lsp > 0 then
    lines[#lines + 1] = "##  LSP Servers"
    for _, server in ipairs(item.lsp) do
      lines[#lines + 1] = "- " .. server .. (vim.list_contains(item.running, server) and " (running)" or "")
    end
    lines[#lines + 1] = ""
  end

  -- Formatters
  if #item.formatters > 0 then
    lines[#lines + 1] = "## 󰉼 Formatters"
    for _, formatter in ipairs(item.formatters) do
      lines[#lines + 1] = "- " .. formatter
    end
    lines[#lines + 1] = ""
  end

  -- Linters
  if #item.linters > 0 then
    lines[#lines + 1] = "## 󰁨 Linters"
    for _, linter in ipairs(item.linters) do
      lines[#lines + 1] = "- " .. linter
    end
    lines[#lines + 1] = ""
  end

  -- DAP
  if #item.dap > 0 then
    lines[#lines + 1] = "## 󰃤 Debug Configurations"
    for _, config in ipairs(item.dap) do
      lines[#lines + 1] = "- " .. config.name
    end
    lines[#lines + 1] = ""
  end

  ctx.preview:set_lines(lines)
  ctx.preview:highlight({ ft = "markdown" })
end

---@type snacks.picker.filetypes.Config
M.source = {
  title = "Filetypes",
  layout = {
    hidden = { "preview" },
    layout = {
      backdrop = false,
      row = 1,
      width = 0.4,
      min_width = 80,
      height = 0.8,
      border = "none",
      box = "vertical",
      { win = "input", height = 1, border = true, title = "{title}", title_pos = "center" },
      { win = "list", height = 18, border = "hpad" },
      { win = "preview", height = 0, border = true, title = "{preview}" },
    },
  },
  sort = { fields = { "active", "text" } },
  matcher = { sort_empty = true },
  finder = M.find,
  format = M.format,
  preview = M.preview,

  confirm = function(picker, item)
    picker:close()
    if item then vim.bo.filetype = item.text end
  end,
}

return M
