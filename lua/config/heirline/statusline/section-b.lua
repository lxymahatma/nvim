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

local Git = {
    condition = function(self) return vim.b.minidiff_summary_string or self.last_branch end,
    hl = { bg = "surface0" },
    init = function(self)
        local status = vim.b.minidiff_summary
        if status then
            self.git_status = status
            self.last_branch = get_git_branch()
            self.has_changes = vim.b.minidiff_summary_string ~= ""
        else
            self.git_status = nil
            self.has_changes = false
        end
    end,
    {
        condition = function(self) return self.last_branch end,
        provider = function(self) return icons.branch .. self.last_branch .. " " end,
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
    Git,
    {
        provider = function(self) return self.sep.left_section end,
        hl = { fg = "surface0", bg = "mantle" },
    },
}
