local M = {}

local hex_cache = {}
for i = 0, 255 do
    hex_cache[i] = string.format("%02X", i)
end

--- @param r integer 0-255
--- @param g integer 0-255
--- @param b integer 0-255
function M.rgb_to_hex(r, g, b) return "#" .. hex_cache[r] .. hex_cache[g] .. hex_cache[b] end

--- @param h number Hue 0-360
--- @param s number Saturation 0-100
--- @param l number Lightness 0-100
function M.hsl_to_hex(h, s, l)
    s = s / 100
    l = l / 100
    local c = (1 - math.abs(2 * l - 1)) * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = l - c / 2
    local r, g, b

    if h < 60 then
        r, g, b = c, x, 0
    elseif h < 120 then
        r, g, b = x, c, 0
    elseif h < 180 then
        r, g, b = 0, c, x
    elseif h < 240 then
        r, g, b = 0, x, c
    elseif h < 300 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end

    r = math.floor((r + m) * 255)
    g = math.floor((g + m) * 255)
    b = math.floor((b + m) * 255)

    return M.rgb_to_hex(r, g, b)
end

return M
