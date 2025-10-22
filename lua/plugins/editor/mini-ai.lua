-- Extend and create a/i textobjects
return {
    "nvim-mini/mini.ai",
    event = "BufEdit",
    opts = function()
        local ai = require("mini.ai")
        return {
            custom_textobjects = {
                o = ai.gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }),
                f = ai.gen_spec.treesitter({
                    a = "@function.outer",
                    i = "@function.inner",
                }),
                c = ai.gen_spec.treesitter({
                    a = "@class.outer",
                    i = "@class.inner",
                }),
            },
            mappings = {
                -- Main textobject prefixes
                around = "a",
                inside = "i",

                -- Next/last variants
                around_next = "an",
                inside_next = "in",
                around_last = "al",
                inside_last = "il",

                -- Move cursor to corresponding edge of `a` textobject
                goto_left = "g[",
                goto_right = "g]",
            },
            n_lines = 50,
            search_method = "cover_or_next",
            silent = false,
        }
    end,
}
