local M = {}

local storage_helper = require("helpers.storage")

M.tab_buffers = {}

---Add buffer to current tab's cache
---@param bufnr number Buffer number
function M.add_buffer_to_current_tab(bufnr)
    local tabnr = vim.api.nvim_tabpage_get_number(0)
    if not M.tab_buffers[tabnr] then M.tab_buffers[tabnr] = {} end
    M.tab_buffers[tabnr][bufnr] = true
end

---Get buffer list as array for a specific tab
---@param tabnr number Tab number
---@return number[] Array of buffer numbers
function M.get_tab_buffer_list(tabnr)
    local buffers = {}
    local tab_bufs = M.tab_buffers[tabnr] or {}
    for bufnr, _ in pairs(tab_bufs) do
        if vim.api.nvim_buf_is_valid(bufnr) then table.insert(buffers, bufnr) end
    end
    return buffers
end

---Remove buffer from all tabs
---@param bufnr number Buffer number
function M.remove_buffer(bufnr)
    for _, bufs in pairs(M.tab_buffers) do
        bufs[bufnr] = nil
    end
end

function M.on_tab_enter()
    vim.schedule(function()
        local tabpage = vim.api.nvim_get_current_tabpage()
        local wins = vim.api.nvim_tabpage_list_wins(tabpage)
        if #wins == 0 then vim.cmd("tabclose") end
    end)
end

function M.on_tab_leave() end

function M.on_tab_close(args)
    local tabnr = tonumber(args.file)
    if tabnr then M.tab_buffers[tabnr] = nil end
end

function M.on_tab_new_entered()
    local tabnr = vim.api.nvim_tabpage_get_number(0)
    if not M.tab_buffers[tabnr] then M.tab_buffers[tabnr] = {} end

    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then M.tab_buffers[tabnr][bufnr] = true end
end

function M.save_tabscope() storage_helper.write_mpack("tabscope", M.tab_buffers) end

function M.load_tabscope()
    if not storage_helper.exists_mpack("tabscope") then return end

    local saved_data = storage_helper.read_mpack("tabscope")
    M.tab_buffers = {}

    for tabnr, buffers in pairs(saved_data) do
        vim.notify(("Tab %s has buffers %s"):format(tabnr, vim.inspect(buffers)), vim.log.levels.DEBUG, { title = "Tabscope Loaded" })
        M.tab_buffers[tabnr] = {}
        for bufnr, _ in pairs(buffers) do
            if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) then M.tab_buffers[tabnr][bufnr] = true end
        end
    end
end

return M
