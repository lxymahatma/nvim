-- Find And Replace
return {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },

    ---@type grug.far.Options
    opts = {},
    keys = {
        {
            "<leader>sr",
            function()
                local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                require("grug-far").open({
                    transient = true,
                    prefills = {
                        filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                })
            end,
            mode = { "n", "x" },
            desc = "Search and Replace",
        },
    },
}
