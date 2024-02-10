{ config, pkgs, ... }:

let
  dapJsServer = builtins.fetchTarball {
    url = "https://github.com/microsoft/vscode-js-debug/releases/download/v1.86.1/js-debug-dap-v1.86.1.tar.gz";
    name = "vscode-js-debug";
  };
in
{
  programs.nixvim.plugins.dap = {
    enable = true;
    signs.dapBreakpoint.text = "🛑";
  };
  programs.nixvim.keymaps = [
    {
      mode = ["n"];
      key = "<leader>dr";
      action = ":DapToggleRepl<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>db";
      action = ":DapToggleBreakpoint<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F3>";
      action = ":DapContinue<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F4>";
      action = ":DapStepOver<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F10>";
      action = ":lua require'dap'.step_back()<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F11>";
      action = ":DapStepInto<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F12>";
      action = ":DapStepOut<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>dt";
      action = ":DapTerminate<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>ds";
      action = ":lua require'dap.ui.widgets'.sidebar(require'dap.ui.widgets'.scopes).open()<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>dh";
      action = ":lua require'dap.ui.widgets'.hover()<CR>";
      options.silent = true;
    }
  ];

  programs.nixvim.extraConfigLua = ''
  vim.g.dap_virtual_text = true
  vim.g.dap_virtual_text_show_scopes = true

  local dap = require('dap')

  dap.adapters = {
    ["pwa-node"] = {
      ["host"] = "localhost",
      ["port"] = "${"$"}{port}",
      ["type"] = "server",
      ["executable"] = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {"${dapJsServer}/src/dapDebugServer.js", "${"$"}{port}"},
      }
    },
    ["coreclr"] = {
      type = 'executable',
      command = '${pkgs.netcoredbg}/bin/netcoredbg',
      args = {'--interpreter=vscode'}
    }
  }

  dap.configurations = {
    ["javascript"] = {
      {
        ["cwd"] = "${"$"}{workspaceFolder}",
        ["name"] = "Launch file",
        ["program"] = "${"$"}{file}",
        ["request"] = "launch",
        ["type"] = "pwa-node"
      }
    },
    ["cs"] = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      }
    }
  }
  '';
}
