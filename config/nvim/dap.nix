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
    extensions.dap-ui = {
      enable = true;
      layouts = [
        {
          elements = [
            {
              id = "scopes";
              size = 0.5;
            }
            {
              id = "stacks";
              size = 0.5;
            }
          ];
          position = "left";
          size = 55;
        }
        {
          elements = [
            {
              id = "repl";
              size = 0.5;
            }
            {
              id = "breakpoints";
              size = 0.5;
            }
          ];
          position = "bottom";
          size = 10;
        }
      ];
    };
  };
  programs.nixvim.keymaps = [
    {
      mode = ["n"];
      key = "<leader>D";
      action = ":lua require('dapui').toggle()<CR>";
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
      host = 'localhost',
      port = '${"$"}{port}',
      type = 'server',
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {"${dapJsServer}/src/dapDebugServer.js", "${"$"}{port}"},
      }
    },
    ["chrome"] = {
      type = 'executable',
      command = "node",
      args = {"${dapJsServer}/src/dapDebugServer.js", "${"$"}{port}"},
    },
    ["netcoredbg"] = {
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
    ["javascriptreact"] = {
      {
        type = "chrome",
        request = "attach",
        program = "${"$"}{file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${"$"}{workspaceFolder}"
      }
    },
    ["typescriptreact"] = {
      {
        type = "chrome",
        request = "attach",
        program = "${"$"}{file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${"$"}{workspaceFolder}"
      }
    },
    ["cs"] = {
      {
        type = "netcoredbg",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            -- Get the current folder name
          local current_folder = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

          -- Construct the path to the project file
          local project_file_path = vim.fn.getcwd() .. '/' .. current_folder .. '.csproj'

          if vim.fn.filereadable(project_file_path) == 0 then
            local dll_path = vim.fn.input('Path to dll', vim.fn.getcwd())
            return dll_path
          end


          -- Read the contents of the project file
          local project_file_content = vim.fn.readfile(project_file_path)

          -- Extract the target framework from the project file content
          local target_framework = ""
          for _, line in ipairs(project_file_content) do
            local match = line:match("<TargetFramework>(.+)</TargetFramework>")
            if match then
              target_framework = match
              break
            end
          end

          -- Construct the DLL path using the target framework
          local dll_path = vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/' .. target_framework .. '/' .. current_folder .. '.dll', 'file')
          
          return dll_path
        end,
      }
    }
  }
  '';
}
