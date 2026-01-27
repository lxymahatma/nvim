--- @type LazyPluginSpec
return {
    "nvim-mini/mini.hipatterns",
    event = "BufEdit",
    opts = function()
        local hipatterns = require("mini.hipatterns")
        local colors = require("config.colors")
        local colorspace = require("helpers.colorspace")
        local filetypes = require("config.constant").filetypes

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

                -- Highlight HSL color codes (e.g., hsl(120, 100%, 50%))
                hsl = {
                    pattern = function()
                        if not vim.tbl_contains(filetypes.web, vim.bo.filetype) then return end
                        return "hsl%(%s*%d+%s*,%s*%d+%%%s*,%s*%d+%%%s*%)"
                    end,
                    group = function(_, _, data)
                        local h, s, l = data.full_match:match("hsl%(%s*(%d+)%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*%)")
                        h = tonumber(h) --- @cast h number
                        s = tonumber(s) --- @cast s number
                        l = tonumber(l) --- @cast l number

                        s = s / 100
                        l = l / 100

                        local hex_color = colorspace.hsl_to_hex(h, s, l)
                        return hipatterns.compute_hex_color_group(hex_color, "bg")
                    end,
                },

                -- Highlight OKLCH color codes (e.g., oklch(50% 0.1 120) oklch(0.5 0.1 120))
                oklch = {
                    pattern = function()
                        if not vim.tbl_contains(filetypes.web, vim.bo.filetype) then return end
                        return "oklch%(%s*[%d%.]+%%?%s+[%d%.]+%s+[%d%.]+%s*%)"
                    end,
                    group = function(_, _, data)
                        local l, l_unit, c, h = data.full_match:match("oklch%(%s*([%d%.]+)(%%?)%s+([%d%.]+)%s+([%d%.]+)%s*%)")

                        l = tonumber(l) --- @cast l number
                        c = tonumber(c) --- @cast c number
                        h = tonumber(h) --- @cast h number

                        l = (l_unit == "%") and (l / 100) or l

                        local hex = colorspace.oklch_to_hex(l, c, h)
                        return hipatterns.compute_hex_color_group(hex, "bg")
                    end,
                },

                -- Highlight Tailwind CSS colors (e.g., bg-blue-500)
                tailwind = {
                    pattern = function()
                        if not vim.tbl_contains(filetypes.web, vim.bo.filetype) then return end
                        return "[%w:-]+%-[a-z%-]+%-%d+"
                    end,
                    group = function(_, _, data)
                        local color, shade = data.full_match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
                        local hex = vim.tbl_get(colors.tailwind, color, tonumber(shade))

                        if not hex then return end
                        return hipatterns.compute_hex_color_group(hex, "bg")
                    end,
                },
            },
        }
    end,
}
