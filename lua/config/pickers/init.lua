local M = {}

local constant = require("config.constant")

function M.setup()
    local picker_files = vim.fn.globpath(constant.picker_dir, "*.lua", false, true)

    for _, file in ipairs(picker_files) do
        local name = vim.fn.fnamemodify(file, ":t:r")

        if name ~= "init" then
            local mod = require("config.pickers." .. name)
            Snacks.picker.sources[name] = mod.source
        end
    end
end

return M
