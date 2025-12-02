return {
    "nvim-mini/mini.operators",
    event = "BufEdit",
    opts = {
        evaluate = {
            prefix = "g=",
        },
        exchange = {
            prefix = "gx",
            reindent_linewise = true,
        },
        multiply = {
            prefix = "gm",
        },
        replace = {
            prefix = "gr",
            reindent_linewise = true,
        },
        sort = {
            prefix = "gs",
        },
    },
}
