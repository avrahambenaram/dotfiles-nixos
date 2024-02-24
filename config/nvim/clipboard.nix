{ config, pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      xclip
    ];
    clipboard = {
      providers.xclip.enable = true;
      register = "unnamedplus";
    };
    keymaps = [
      {
        key = "<C-y>";
        action = "\"+y";
        options.silent = true;
      }
    ];
  };
}
