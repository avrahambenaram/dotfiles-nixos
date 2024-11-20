{ pkgs, ... }:

let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins.trouble = {
    enable = true;
    package = pkgs.old.vimPlugins.trouble-nvim;
  };
  programs.nixvim.keymaps = [
    (generateKeymap "n" "<leader>xw" ":lua (function() require('trouble').toggle('workspace_diagnostics') end)()<CR>")
    (generateKeymap "n" "<leader>xd" ":lua (function() require('trouble').toggle('document_diagnostics') end)()<CR>")
    (generateKeymap "n" "<leader>xq" ":TroubleToggle quickfix<cr>")
  ];
}
