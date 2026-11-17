---@type LazyPluginSpec[]
return {
  -- DAP Core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap, toolchain = require("dap"), require("toolchain")
      dap.configurations = toolchain.get_dap_configurations()
      dap.adapters = toolchain.get_dap_adapters()
    end,
    init = function()
      for name, icon in pairs(require("config.icons").dap) do
        vim.fn.sign_define("Dap" .. name, { text = icon, texthl = "Dap" .. name })
      end
      vim.fn.sign_define("DapStopped", { linehl = "debugPC" })
    end,
    keys = {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Run/Continue",
      },
      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function() require("dap").goto_() end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function() require("dap").down() end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function() require("dap").up() end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function() require("dap").step_out() end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function() require("dap").step_over() end,
        desc = "Step Over",
      },
      {
        "<leader>dP",
        function() require("dap").pause() end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dt",
        function() require("dap").terminate() end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function() require("dap.ui.widgets").hover() end,
        desc = "Widgets",
      },
    },
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {},
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end
    end,
    keys = {
      {
        "<leader>du",
        function() require("dapui").toggle({}) end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function() require("dapui").eval() end,
        desc = "Eval",
        mode = { "n", "x" },
      },
    },
  },

  -- DAP Virtual Text
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {},
  },
}
