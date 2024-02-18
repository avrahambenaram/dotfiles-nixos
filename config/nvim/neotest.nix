{ config, pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    neotest
    neotest-jest
    neotest-dotnet
  ];
  programs.nixvim.extraConfigLua = ''
require("neotest").setup({
  adapters = {
    require("neotest-dotnet"),
    require('neotest-jest')({
      jestCommand = "npm test --",
      jestConfigFile = "jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})
  '';
  programs.nixvim.keymaps = [
    {
      key = "<leader>dn";
      action = ":lua require('neotest').run.run({strategy = 'dap'})<CR>";
      options.silent = true;
    }
    {
      key = "<leader>dr";
      action = ":lua require('neotest').run.run({ vim.fn.expand('%') })<CR>";
      options.silent = true;
    }
  ];
}
