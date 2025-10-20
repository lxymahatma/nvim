-- Comment lines
return {
    "nvim-mini/mini.comment",
    event = "BufEdit",
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
}
