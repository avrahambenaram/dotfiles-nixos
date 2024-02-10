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
    {
      mode = ["n" "v" "i"];
      key = "<C-s>1";
      action = ":lua require('luasnip').jump(1)<CR>";
      options.silent = true;
    }
    {
      mode = ["n" "v" "i"];
      key = "<C-s>2";
      action = ":lua require('luasnip').jump(-1)<CR>";
      options.silent = true;
    }
  ];
}
