local constant = require("config.constant")
local tool_loader = require("helpers.tool-loader")

local default_tools = constant.default_tools

local function get_available_tools_for_enable()
    local all_tools = tool_loader.get_all_tools()
    local enabled_tools = tool_loader.get_enabled_tools()

    local available_tools = {}
    for _, tool in ipairs(all_tools) do
        if not vim.tbl_contains(enabled_tools, tool) then
            table.insert(available_tools, tool)
        end
    end
    return available_tools
end

local function get_available_tools_for_disable()
    return tool_loader.get_extra_tools()
end

vim.api.nvim_create_user_command("ToolEnable", function(opts)
    local tools_to_add = opts.fargs
    if #tools_to_add == 0 then
        vim.notify("ToolEnable: No tools specified. Usage: :ToolEnable <tool1> <tool2> ...", vim.log.levels.ERROR)
        return
    end

    local extra_tools = tool_loader.get_extra_tools()

    for _, tool in ipairs(tools_to_add) do
        if vim.tbl_contains(default_tools, tool) then
            vim.notify(string.format("ToolEnable: Tool '%s' is enabled by default.", tool), vim.log.levels.WARN)
        elseif vim.tbl_contains(extra_tools, tool) then
            vim.notify(string.format("ToolEnable: Tool '%s' is already enabled.", tool), vim.log.levels.WARN)
        else
            table.insert(extra_tools, tool)
        end
    end

    tool_loader.save_extra_tools(extra_tools)

    vim.notify(
        string.format("ToolEnable: Added tools: %s. Restart Neovim to apply changes.", table.concat(tools_to_add, ", ")),
        vim.log.levels.INFO
    )
end, {
    nargs = "+",
    complete = get_available_tools_for_enable,
    desc = "Enable tool support",
})

vim.api.nvim_create_user_command("ToolDisable", function(opts)
    local tools_to_remove = opts.fargs
    if #tools_to_remove == 0 then
        vim.notify("ToolDisable: No tools specified. Usage: :ToolDisable <tool1> <tool2> ...", vim.log.levels.ERROR)
        return
    end

    local extra_tools = tool_loader.get_extra_tools()
    if #extra_tools == 0 then
        vim.notify("ToolDisable: No local configuration found. No tools to disable.", vim.log.levels.WARN)
        return
    end

    local removed_tools = {}

    for _, tool in ipairs(tools_to_remove) do
        if vim.tbl_contains(default_tools, tool) then
            vim.notify(("ToolDisable: '%s' cannot be disabled."):format(tool), vim.log.levels.WARN)
        elseif vim.tbl_contains(extra_tools, tool) then
            extra_tools = vim.tbl_filter(function(v) return v ~= tool end, extra_tools)
            table.insert(removed_tools, tool)
        else
            vim.notify(("ToolDisable: '%s' is not enabled."):format(tool), vim.log.levels.WARN)
        end
    end

    tool_loader.save_extra_tools(extra_tools)

    vim.notify(
        string.format("ToolDisable: Removed tools: %s. Restart Neovim to apply changes.", table.concat(removed_tools, ", ")),
        vim.log.levels.INFO
    )
end, {
    nargs = "+",
    complete = get_available_tools_for_disable,
    desc = "Disable tool support",
})
