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
  programs.nixvim.keymaps = [
    {
      mode = ["i" "s"];
      key = "<C-n>";
      action = "<Plug>luasnip-next-choice";
    }
    {
      mode = ["i" "s"];
      key = "<C-p>";
      action = "<Plug>luasnip-prev-choice";
    }
  ];
}
