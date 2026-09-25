local icons = require("config.icons")

---@return string?
local function read_git_branch()
  local name = vim.api.nvim_buf_get_name(0)
  local start = name ~= "" and vim.fs.dirname(name) or vim.uv.cwd()
  local dot_git = vim.fs.find(".git", { path = start, upward = true })[1]
  if not dot_git then return nil end

  local git_dir = dot_git
  if vim.fn.isdirectory(dot_git) == 0 then
    local f = io.open(dot_git, "r")
    if not f then return nil end
    local target = (f:read("*l") or ""):match("^gitdir: (.+)$")
    f:close()
    if not target then return nil end

    local is_absolute = target:match("^/") or target:match("^%a:[/\\]")
    git_dir = is_absolute and target or vim.fs.joinpath(vim.fs.dirname(dot_git), target)
  end

  local f = io.open(git_dir .. "/HEAD", "r")
  if not f then return nil end

  local content = f:read("*l")
  f:close()
  if not content then return nil end

  local branch = content:match("ref: refs/heads/(.+)$")
  return branch or content:sub(1, 6)
end

local Branch = {
  update = { "BufEnter", "FocusGained", "DirChanged", "ModeChanged" },
  init = function(self) self.branch = read_git_branch() end,
  provider = function(self) return self.branch and (icons.branch .. self.branch .. " ") end,
  hl = function(self) return { fg = self.mode_colors[self.mode_key] } end,
}

local Git = {
  condition = function(self) return self.has_git end,
  hl = { bg = "surface0" },
  init = function(self)
    self.git_status = vim.b.minidiff_summary
    self.has_changes = vim.b.minidiff_summary_string ~= ""
  end,
  Branch,
  {
    condition = function(self) return self.has_changes end,
    {
      provider = function(self) return self.sep.left_component end,
      hl = { fg = "text" },
    },
    {
      provider = function(self) return self.git_status.add > 0 and ("+" .. self.git_status.add .. " ") end,
      hl = "MiniDiffSignAdd",
    },
    {
      provider = function(self) return self.git_status.change > 0 and ("~" .. self.git_status.change .. " ") end,
      hl = "MiniDiffSignChange",
    },
    {
      provider = function(self) return self.git_status.delete > 0 and ("-" .. self.git_status.delete .. " ") end,
      hl = "MiniDiffSignDelete",
    },
  },
}

return {
  condition = function(self) return self.has_git end,
  Git,
  {
    provider = function(self) return self.sep.left_section end,
    hl = { fg = "surface0", bg = "mantle" },
  },
}
