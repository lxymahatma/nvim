-- Find And Replace
return {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    keys = {
        {
            "<leader>fr",
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
            desc = "Find and Replace",
        },
    },
}
