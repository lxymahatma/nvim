-- Enhance Ctrl-A/X

---@param direction "increment" | "decrement"
---@param g boolean
local function dial(direction, g)
    local is_visual = vim.fn.mode(true):find("^[vV\22]")
    local mode = (g and "g" or "") .. (is_visual and "visual" or "normal")

    ---@cast direction direction
    ---@cast mode mode
    return require("dial.map").manipulate(direction, mode)
end

---@type LazyPluginSpec
return {
    "monaqa/dial.nvim",
    opts = function()
        local augend = require("dial.augend")

        return {
            groups = {
                default = {
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.constant.alias.Bool,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%m/%d/%Y"],
                    augend.date.alias["%Y年%-m月%-d日"],
                    augend.date.new({
                        pattern = "%Y/%m/%d",
                        default_kind = "day" --[[@as datekind]],
                        only_valid = true,
                        word = false,
                    }),
                    augend.semver.alias.semver,
                    augend.misc.alias.markdown_header,
                },
            },
        }
    end,
    config = function(_, opts) require("dial.config").augends:register_group(opts.groups) end,
    keys = {
        { "<C-a>",  function() return dial("increment", false) end, desc = "Increment", mode = { "n", "v" } },
        { "<C-x>",  function() return dial("decrement", false) end, desc = "Decrement", mode = { "n", "v" } },
        { "g<C-a>", function() return dial("increment", true) end,  desc = "Increment", mode = { "n", "x" } },
        { "g<C-x>", function() return dial("decrement", true) end,  desc = "Decrement", mode = { "n", "x" } },
    },
}
