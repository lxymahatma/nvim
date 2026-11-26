-- QOL collections

---@param direction "h" | "j" | "k" | "l"
local function term_nav(direction)
  ---@param self snacks.terminal
  return function(self)
    -- A floating terminal gets the key itself
    return self:is_floating() and "<C-" .. direction .. ">" or vim.schedule(function() vim.cmd.wincmd(direction) end)
  end
end

---@type LazyPluginSpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
██╗     ███████╗██╗  ██╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
██║     ██╔════╝╚██╗██╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║
██║     █████╗   ╚███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║
██║     ██╔══╝   ██╔██╗   ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗███████╗██╔╝ ██╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
                ]],
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          {
            icon = "󰔛 ",
            key = "P",
            desc = "Lazy Profile",
            action = ":Lazy profile",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    explorer = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true, configure = false },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      matcher = {
        frecency = true,
      },
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          diagnostics_open = true,
          git_status_open = true,
        },
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
        grep_word = {
          hidden = true,
        },
      },
      win = {
        input = {
          keys = {
            ["<M-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
            ["<M-t>"] = { "trouble_open", mode = { "n", "i" } },
          },
        },
        preview = { wo = { wrap = true } },
      },
      actions = {
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
        ---@diagnostic disable-next-line: need-check-nil
        trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = {
      enabled = true,
      folds = {
        open = true,
        git_hl = true,
      },
    },
    terminal = {
      win = {
        keys = {
          nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
          nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
          nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
          nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
        },
      },
    },
    words = { enabled = true },
    styles = {
      notification_history = { wo = { wrap = true } },
    },
  },
  config = function(_, opts)
    table.insert(require("snacks.image.terminal").envs(), {
      name = "rex",
      terminal = "rex",
      supported = true,
      placeholders = true,
    })
    require("snacks").setup(opts)
  end,
}
