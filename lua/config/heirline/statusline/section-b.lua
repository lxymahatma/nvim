local icons = require("config.icons")

---@return string?
local function get_git_branch()
    local git_dir = vim.fn.finddir(".git", ".;")
    if git_dir == "" then return nil end

    local head_file = git_dir .. "/HEAD"
    local f = io.open(head_file, "r")
    if not f then return nil end

    local content = f:read("*l")
    f:close()

    local branch = content:match("ref: refs/heads/(.+)$")
    return branch and branch or content:sub(1, 6)
end

local function has_git() return vim.b.minidiff_summary ~= nil end

local Git = {
    condition = has_git,
    hl = { bg = "surface0" },
    init = function(self)
        self.git_status = vim.b.minidiff_summary
        self.branch = get_git_branch()
        self.has_changes = vim.b.minidiff_summary_string ~= ""
    end,
    {
        condition = function(self) return self.branch end,
        provider = function(self) return icons.branch .. self.branch .. " " end,
        hl = function(self) return { fg = self.mode_colors[self.mode_key] } end,
    },
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
    condition = function() return has_git() end,
    Git,
    {
        provider = function(self) return self.sep.left_section end,
        hl = { fg = "surface0", bg = "mantle" },
    },
}
