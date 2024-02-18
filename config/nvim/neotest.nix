{ config, pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    neotest
    neotest-vitest
    neotest-dotnet
  ];
  programs.nixvim.extraConfigLua = ''
require("neotest").setup({
  adapters = {
    require("neotest-dotnet")
  }
})
  '';
  programs.nixvim.keymaps = [
    {
      key = "<leader>dn";
      action = ":lua require('neotest').run.run({strategy = 'dap'})<CR>";
      options.silent = true;
    }
  ];
}
