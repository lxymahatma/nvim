--- @type LazyPluginSpec
return {
    "nvim-mini/mini.hipatterns",
    event = "BufEdit",
    opts = function()
        local hipatterns = require("mini.hipatterns")
        local colors = require("config.colors")

        return {
            highlighters = {
                -- Highlight hex color codes (e.g., #FF5733)
                hex_color = hipatterns.gen_highlighter.hex_color(),

                -- Highlight short hex color codes (e.g., #F53)
                hex_color_short = {
                    pattern = "#%x%x%x%f[%X]",
                    group = function(_, _, data)
                        --- @type string
                        local match = data.full_match
                        local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
                        local hex_color = "#" .. r .. r .. g .. g .. b .. b

                        return hipatterns.compute_hex_color_group(hex_color, "bg")
                    end,
                },

                -- Highlight Tailwind CSS colors (e.g., bg-blue-500)
                tailwind = {
                    pattern = "[%w-]+%-[%a-]+%-%d+",
                    group = function(_, _, data)
                        local color, shade = data.full_match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
                        local hex = vim.tbl_get(colors.tailwind, color, tonumber(shade))
                        if hex then return hipatterns.compute_hex_color_group(hex, "bg") end
                        return nil
                    end,
                },
            },
        }
    end,
}
