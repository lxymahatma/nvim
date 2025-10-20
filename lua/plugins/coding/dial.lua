-- Enhance Ctrl-A/X
return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>",  "<Plug>(dial-increment)",  mode = { "n", "v" } },
        { "<C-x>",  "<Plug>(dial-decrement)",  mode = { "n", "v" } },
        { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true },
        { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true },
    },
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal_int,
                augend.integer.alias.hex,
                augend.constant.alias.bool,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%m/%d/%Y"],
                augend.date.alias["%Y年%-m月%-d日"],
                augend.date.new({
                    pattern = "%Y/%m/%d",
                    default_kind = "day",
                    only_valid = true,
                    word = false,
                }),
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
                augend.semver.alias.semver,
                augend.misc.alias.markdown_header,
            },
        })
    end,
}
