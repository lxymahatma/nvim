--- @type LazyPluginSpec
return {
    "nvim-mini/mini.hipatterns",
    event = "BufEdit",
    opts = function()
        local hipatterns = require("mini.hipatterns")
        local colors = require("config.colors")
        local colorspace = require("helpers.colorspace")
        local filetypes = require("config.constant").filetypes

        --- @type table<string, string?>
        local color_cache = {}

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

                -- Highlight RGB(A) color codes (e.g., rgb(255 87 51) or rgb(255 87 51 / 0.5))
                rgb = {
                    pattern = function()
                        if not vim.tbl_contains(filetypes.web, vim.bo.filetype) then return end
                        return "rgb%(%s*%d+[%s,]+%d+[%s,]+%d+[%s/]*[%d%.]*%%?%s*%)"
                    end,
                    group = function(_, _, data)
                        local color_str = data.full_match
                        local cached_hex = color_cache[color_str]
                        vim.notify(color_str)
                        if cached_hex then return hipatterns.compute_hex_color_group(cached_hex, "bg") end

                        local r, g, b = color_str:match("rgb%(%s*(%d+)[%s,]+(%d+)[%s,]+(%d+)")
                        r = tonumber(r) --- @cast r integer
                        g = tonumber(g) --- @cast g integer
                        b = tonumber(b) --- @cast b integer

                        local hex = colorspace.rgb_to_hex(r, g, b)
                        color_cache[color_str] = hex
                        return hipatterns.compute_hex_color_group(hex, "bg")
                    end,
                },

                -- Highlight HSL color codes (e.g., hsl(120, 100%, 50%))
                hsl = {
                    pattern = function()
                        if not vim.tbl_contains(filetypes.web, vim.bo.filetype) then return end
                        return "hsl%(%s*%d+%s*,%s*%d+%%%s*,%s*%d+%%%s*%)"
                    end,
                    group = function(_, _, data)
                        local color_str = data.full_match
                        local cached_hex = color_cache[color_str]
                        if cached_hex then return hipatterns.compute_hex_color_group(cached_hex, "bg") end

                        local h, s, l = color_str:match("hsl%(%s*(%d+)%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*%)")
                        h = tonumber(h) --- @cast h number
                        s = tonumber(s) --- @cast s number
                        l = tonumber(l) --- @cast l number

                        s = s / 100
                        l = l / 100

                        local hex = colorspace.hsl_to_hex(h, s, l)
                        color_cache[color_str] = hex
                        return hipatterns.compute_hex_color_group(hex, "bg")
                    end,
                },

                -- Highlight OKLCH color codes (e.g., oklch(50% 0.1 120) oklch(0.5 0.1 120))
                oklch = {
                    pattern = function()
                        if not vim.tbl_contains(filetypes.web, vim.bo.filetype) then return end
                        return "oklch%(%s*[%d%.]+%%?%s+[%d%.]+%s+[%d%.]+%s*%)"
                    end,
                    group = function(_, _, data)
                        local color_str = data.full_match
                        local cached_hex = color_cache[color_str]
                        if cached_hex then return hipatterns.compute_hex_color_group(cached_hex, "bg") end

                        local l, l_unit, c, h = color_str:match("oklch%(%s*([%d%.]+)(%%?)%s+([%d%.]+)%s+([%d%.]+)%s*%)")

                        l = tonumber(l) --- @cast l number
                        c = tonumber(c) --- @cast c number
                        h = tonumber(h) --- @cast h number

                        l = (l_unit == "%") and (l / 100) or l

                        local hex = colorspace.oklch_to_hex(l, c, h)
                        color_cache[color_str] = hex
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
                        local color_str = data.full_match
                        -- Ignore negative variants or css variable declarations
                        if color_str:sub(1, 1) == "-" then return end

                        local cached_hex = color_cache[color_str]
                        if cached_hex then return hipatterns.compute_hex_color_group(cached_hex, "bg") end

                        local color, shade = data.full_match:match("[%w-]+%-([a-z%-]+)%-(%d+)")
                        local hex = vim.tbl_get(colors.tailwind, color, tonumber(shade))

                        if not hex then return end
                        color_cache[color_str] = hex
                        return hipatterns.compute_hex_color_group(hex, "bg")
                    end,
                },
            },
        }
    end,
}
