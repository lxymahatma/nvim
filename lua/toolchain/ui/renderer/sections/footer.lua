local Footer = {}

local function center(text, width)
    local padding = math.floor((width - vim.fn.strdisplaywidth(text)) / 2)
    return string.rep(" ", padding) .. text
end

--- @param state ToolchainState
--- @return ToolchainRenderChunk
function Footer.render(state)
    local help_text = "<CR> Toggle  q Close"
    return {
        lines = {
            string.rep("─", state.width - 2),
            center(help_text, state.width),
            "",
        },
    }
end

return Footer
