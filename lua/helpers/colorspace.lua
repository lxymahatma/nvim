local M = {}

local hex_cache = {}
for i = 0, 255 do
    hex_cache[i] = string.format("%02X", i)
end

--- @param val number
--- @return number
local function to_srgb(val)
    if val <= 0.0031308 then
        return math.max(0, 12.92 * val)
    else
        return 1.055 * (val ^ (1 / 2.4)) - 0.055
    end
end

--- @param val number
--- @return integer
local function clamp255(val)
    if val <= 0 then return 0 end
    if val >= 1 then return 255 end
    return math.floor(val * 255 + 0.5)
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

--- @param l number Lightness 0-1
--- @param c number Chroma 0-0.4
--- @param h number Hue 0-360
function M.oklch_to_hex(l, c, h)
    local hue_rad = math.rad(h)
    local lab_a = c * math.cos(hue_rad)
    local lab_b = c * math.sin(hue_rad)

    local l_raw = l + 0.3963377774 * lab_a + 0.2158037573 * lab_b
    local m_raw = l - 0.1055613458 * lab_a - 0.0638541728 * lab_b
    local s_raw = l - 0.0894841775 * lab_a - 1.2914855480 * lab_b

    local lp = l_raw * l_raw * l_raw
    local mp = m_raw * m_raw * m_raw
    local sp = s_raw * s_raw * s_raw

    local r_lin = 4.0767416621 * lp - 3.3077115913 * mp + 0.2309699292 * sp
    local g_lin = -1.2684380046 * lp + 2.6097574011 * mp - 0.3413193965 * sp
    local b_lin = -0.0041960863 * lp - 0.7034186147 * mp + 1.7076147010 * sp

    local r = to_srgb(r_lin)
    local g = to_srgb(g_lin)
    local b = to_srgb(b_lin)

    return M.rgb_to_hex(clamp255(r), clamp255(g), clamp255(b))
end

return M
