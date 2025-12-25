local M = {}

local constant = require("config.constant")

function M.setup()
    for name in vim.fs.dir(constant.picker_dir) do
        if name ~= "init.lua" then
            local key = name:sub(1, -5)
            local mod = require("config.pickers." .. key)
            Snacks.picker.sources[key] = mod.source
        end
    end
end

return M
