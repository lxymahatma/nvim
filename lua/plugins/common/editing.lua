return {
    -- Extend and create a/i textobjects
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = {
            custom_textobjects = nil,
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
        },
    },

    -- Comment lines
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                ignore_blank_line = true,

                -- Whether to recognize as comment only lines without indent
                start_of_line = false,

                -- Whether to force single space inner padding for comment parts
                pad_comment_parts = true,
            },
            mappings = {
                -- Normal and Visual modes
                comment = "gc",

                -- Toggle comment on current line
                comment_line = "gcc",

                -- Toggle comment on visual selection
                comment_visual = "gc",

                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                textobject = "gc",
            },
        },
    },

    -- Move any selection in any direction
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {
            mappings = {
                -- Move visual selection in Visual mode
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",

                -- Move current line in Normal mode
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },

            options = {
                reindent_linewise = true,
            },
        },
    },

    -- Fast and feature-rich surround actions
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {
            highlight_duration = 500,
            mappings = {
                add = "sa",            -- Add surrounding in Normal and Visual modes
                delete = "sd",         -- Delete surrounding
                find = "sf",           -- Find surrounding (to the right)
                find_left = "sF",      -- Find surrounding (to the left)
                highlight = "sh",      -- Highlight surrounding
                replace = "sr",        -- Replace surrounding
                update_n_lines = "sn", -- Update `n_lines`

                suffix_last = "l",     -- Suffix to search with "prev" method
                suffix_next = "n",     -- Suffix to search with "next" method
            },
        },
    },

    -- Enhance Ctrl-A/X
    {
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
    },
}
