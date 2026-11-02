local api = vim.api
local constant = require("config.constant")
local icons = require("config.icons").toolchain
local loader = require("toolchain.loader")

local ns = api.nvim_create_namespace("toolchain_ui")
local header_height = 3

---@type ({ key: ToolchainTab, label: string })[]
local tabs = { { key = "all", label = "All" } }
---@type table<ToolchainType, string>
local labels = {}
for _, toolchain_type in ipairs(constant.toolchain_types) do
  local label = toolchain_type.name:gsub("^%l", string.upper)
  table.insert(tabs, { key = toolchain_type.name, label = label })
  labels[toolchain_type.name] = label
end

---@param tab ToolchainTab
---@return ToolchainItem[]
local function filter_items(tab)
  return vim.tbl_filter(function(item) return tab == "all" or item.type == tab end, loader.items)
end

local M = {}

function M.open()
  local current_tab, items = "all", filter_items("all") ---@type ToolchainTab, ToolchainItem[]
  local buf = api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "toolchain"

  local width = math.floor(vim.o.columns * 0.4)
  local height = math.floor(vim.o.lines * 0.8)
  local win = api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = "minimal",
    border = "rounded",
    title = " Toolchain ",
    title_pos = "center",
  })
  vim.wo[win].cursorline = true
  vim.wo[win].winhl = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual"

  local function render()
    local lines, highlights = { "", "  " }, {}
    for i, tab in ipairs(tabs) do
      local tab_items = filter_items(tab.key)
      local enabled = #vim.tbl_filter(function(item) return item.enabled end, tab_items)
      local active = tab.key == current_tab
      local icon = active and icons.tab_active or icons.tab_inactive
      local text = (" %s %s (%d/%d) "):format(icon, tab.label, enabled, #tab_items)
      local col = #lines[2]
      table.insert(highlights, { 1, col, col + #text, active and "ToolchainTabActive" or "ToolchainTabInactive" })
      lines[2] = lines[2] .. text .. (i < #tabs and " " or "")
    end
    table.insert(lines, ("─"):rep(width - 2))

    for _, item in ipairs(items) do
      local label = labels[item.type]
      local blocker = loader.blocked_by(item)
      local state = item.enabled and "Enabled" or blocker and "Blocked" or "Disabled"
      local line = ""
      for _, part in ipairs({
        { "  " },
        { icons[state:lower()], "Toolchain" .. state },
        { "  " },
        { ("%-20s"):format(item.name), "ToolchainName" },
        { "  " },
        { "[" .. label .. "]", "ToolchainType" .. label },
        { item.is_default and " " .. icons.default or "", "ToolchainDefault" },
        { blocker and "  blocked by " .. blocker.name or "", "ToolchainBlockedBy" },
      }) do
        local text, hl_group = part[1], part[2]
        if hl_group and text ~= "" then table.insert(highlights, { #lines, #line, #line + #text, hl_group }) end
        line = line .. text
      end
      table.insert(lines, line)
    end

    -- Keep the 3 footer lines at the bottom of the window
    for _ = 1, height - #lines - 3 do
      table.insert(lines, "")
    end
    local help = "<CR> Toggle  q Close"
    help = (" "):rep(math.floor((width - vim.fn.strdisplaywidth(help)) / 2)) .. help
    table.insert(lines, ("─"):rep(width - 2))
    table.insert(highlights, { #lines, 0, #help, "ToolchainFooter" })
    vim.list_extend(lines, { help, "" })

    vim.bo[buf].modifiable = true
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    for _, hl in ipairs(highlights) do
      api.nvim_buf_set_extmark(buf, ns, hl[1], hl[2], { end_col = hl[3], hl_group = hl[4] })
    end
  end

  -- Keep the cursor on the items
  api.nvim_create_autocmd("CursorMoved", {
    buffer = buf,
    callback = function()
      local row = api.nvim_win_get_cursor(win)[1]
      local clamped = math.max(header_height + 1, math.min(header_height + #items, row))
      if clamped ~= row then api.nvim_win_set_cursor(win, { clamped, 0 }) end
    end,
  })

  local function close()
    pcall(api.nvim_win_close, win, true)
  end
  -- Leaving the buffer saves once, also when closing the window
  api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    once = true,
    callback = function()
      loader.save()
      vim.schedule(close)
    end,
  })

  local function map(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { buffer = buf, nowait = true, silent = true })
  end
  map("q", close)
  map("<Esc>", close)
  map("<CR>", function()
    local item = items[api.nvim_win_get_cursor(win)[1] - header_height]
    local ok, message = loader.toggle(item)
    if ok then render() end
    vim.notify(message, ok and vim.log.levels.INFO or vim.log.levels.WARN)
  end)
  for i, tab in ipairs(tabs) do
    map(tostring(i), function()
      current_tab, items = tab.key, filter_items(tab.key)
      render()
      api.nvim_win_set_cursor(win, { header_height + 1, 0 })
    end)
  end

  render()
  api.nvim_win_set_cursor(win, { header_height + 1, 0 })
end

return M
