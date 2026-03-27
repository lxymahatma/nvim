local M = {}

---@param opts snacks.picker.ast_grep.Config
---@param filter snacks.picker.Filter
local function get_cmd(opts, filter)
    local cmd = "ast-grep"
    local args = {
        "run",
        "--color=never",
        "--json=stream",
    }

    if opts.hidden then args[#args + 1] = "--no-ignore=hidden" end

    if opts.ignored then args[#args + 1] = "--no-ignore=vcs" end

    local pattern, pargs = Snacks.picker.util.parse(filter.search)
    args[#args + 1] = "--pattern=" .. pattern
    vim.list_extend(args, pargs)

    return cmd, args
end

---@param opts snacks.picker.ast_grep.Config
---@param ctx snacks.picker.finder.ctx
---@return snacks.picker.finder
function M.find(opts, ctx)
    if opts.need_search ~= false and ctx.filter.search == "" then
        return function() end
    end

    local absolute = (opts.dirs and #opts.dirs > 0) or opts.buffers or opts.rtp
    local cwd = not absolute and svim.fs.normalize(opts and opts.cwd or vim.uv.cwd() or ".") or nil
    local cmd, args = get_cmd(opts, ctx.filter)

    return require("snacks.picker.source.proc").proc(
        ctx:opts({
            notify = false,
            cmd = cmd,
            args = args,
            ---@param item snacks.picker.finder.Item
            transform = function(item)
                local ok, entry = pcall(vim.json.decode, item.text)
                if not ok or type(entry) ~= "table" or vim.tbl_isempty(entry) then return false end

                local range = entry.range
                local start = range and range.start
                if not start or not entry.file then return false end

                local line = tonumber(start.line)
                local col = tonumber(start.column)
                if not line or not col then return false end

                item.cwd = cwd
                item.file = entry.file
                item.line = entry.text or ""
                item.pos = { line + 1, col }
            end,
        }),
        ctx
    )
end

---@type snacks.picker.ast_grep.Config
M.source = {
    title = "AST Grep",
    finder = M.find,
    format = "file",
    show_empty = true,
    live = true,
    supports_live = true,
}

return M
