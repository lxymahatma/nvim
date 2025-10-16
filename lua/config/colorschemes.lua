local M = {}

function M.setup(colorscheme)
    if colorscheme:find("^tokyonight") or colorscheme:find("^catppuccin") then
        vim.cmd("colorscheme " .. colorscheme)
    end
end

return M
