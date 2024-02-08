{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    nvim-cmp.snippet.expand = "luasnip";
    cmp_luasnip.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [{
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }];
    };
  };
}
