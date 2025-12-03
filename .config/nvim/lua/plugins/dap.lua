return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},

        config = function()
            require("dapui").setup()
            local dap = require("dap")

            --
            -- Addaptors
            --
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }
            dap.adapters.debugpy = {
                type = 'executable';
                command = 'python3';
                args = { '-m', 'debugpy.adapter' };
            }

            --
            -- Configurations
            --
            dap.configurations.python = {
              {
                type = 'debugpy';
                request = 'launch';
                name = "Launch file";
                program = "${file}";
                pythonPath = function()
                  return '/usr/bin/python3'
                end;
              },
            }
            dap.configurations.c = {
              {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                args = function ()
                   return vim.fn.input('Inferior args: ')
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = true
              },
              {
                name = "Just launch",
                type = "gdb",
                request = "launch",
                cwd = "${workspaceFolder}",
              },
              {
                name = "Select and attach to process",
                type = "gdb",
                request = "attach",
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                pid = function()
                  local name = vim.fn.input('Executable name (filter): ')
                  return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = '${workspaceFolder}'
              },
              {
                name = 'Attach to gdbserver :1234',
                type = 'gdb',
                request = 'attach',
                target = 'localhost:1234',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}'
              }
            }
            dap.configurations.cpp = dap.configurations.c
        end,
    }
}
