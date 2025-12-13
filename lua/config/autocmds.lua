vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("quit", { clear = true }),
    pattern = {
        "checkhealth",
        "gitsigns-blame",
        "grug-far",
        "help",
        "man",
        "notify",
        "qf",
        "vim",
    },
    callback = function(args)
        vim.bo[args.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
            end, {
                buffer = args.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = require("langs.lang-parser").get_filetypes(),
    callback = function() vim.treesitter.start() end,
    group = vim.api.nvim_create_augroup("LangTreesitter", { clear = true }),
})
