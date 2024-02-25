{ config, pkgs, ... }:

let
  generateKeymap = import ./utils/generateKeymap.nix;
in
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
    (generateKeymap "n" "<leader>dn" ":lua require('neotest').run.run({strategy = 'dap'})<CR>")
    (generateKeymap "n" "<leader>dr" ":lua require('neotest').run.run({ vim.fn.expand('%') })<CR>")
  ];
}
