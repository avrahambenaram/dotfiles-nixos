{ config, pkgs, ... }:

let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins = {
    nvim-cmp.snippet.expand = "luasnip";
    cmp_luasnip.enable = true;
    friendly-snippets.enable = true;
    luasnip = {
      enable = true;
    };
  };
  programs.nixvim.keymaps = [
    (generateKeymap ["i" "s"] "<C-n>" "<Plug>luasnip-next-choice")
    (generateKeymap ["i" "s"] "<C-p>" "<Plug>luasnip-prev-choice")
  ];
}
