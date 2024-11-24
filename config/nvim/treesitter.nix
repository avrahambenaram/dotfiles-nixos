{ pkgs, ... }:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      highlight = {
        enable = true;
        disable = ["html"];
      };
    };
  };
  programs.nixvim.plugins.rainbow-delimiters.enable = true;
}
