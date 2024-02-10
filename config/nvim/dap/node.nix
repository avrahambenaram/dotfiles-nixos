let
  dapJsServer = builtins.fetchTarball {
    url = "https://github.com/microsoft/vscode-js-debug/releases/download/v1.86.1/js-debug-dap-v1.86.1.tar.gz";
    name = "vscode-js-debug";
  };
in
{
  programs.nixvim.configurations.javascript = [{
    type = "pwa-node";
    name = "Launch file";
    request = "launch";
    program = "\${file}";
    cwd = "\${workspaceFolder}";
  }]
  programs.nixvim.extraConfigLua = ''
  require('dap').adapters = {
    ["pwa-node"] = {
      ["host"] = "localhost",
      ["port"] = "${"$"}{port}",
      ["type"] = "server",
      ["executable"] = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {"${dapJsServer}/src/dapDebugServer.js", "${"$"}{port}"},
      }
    }
  }
  '';
}
