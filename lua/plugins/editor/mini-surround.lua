-- Fast and feature-rich surround actions
return {
    "nvim-mini/mini.surround",
    event = "BufEdit",
    opts = {
        highlight_duration = 500,
        mappings = {
            add = "sa",            -- Add surrounding in Normal and Visual modes
            delete = "sd",         -- Delete surrounding
            find = "",             -- Find surrounding (to the right)
            find_left = "",        -- Find surrounding (to the left)
            highlight = "",        -- Highlight surrounding
            replace = "sr",        -- Replace surrounding
            update_n_lines = "sn", -- Update `n_lines`

            suffix_last = "l",     -- Suffix to search with "prev" method
            suffix_next = "n",     -- Suffix to search with "next" method
        },
    },
}
