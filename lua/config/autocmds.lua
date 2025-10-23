vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("quit", { clear = true }),
    pattern = {
        "checkhealth",
        "grug-far",
        "help",
        "man",
        "notify",
        "vim",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})
