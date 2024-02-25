{ config, pkgs, ... }:

let
  generateKeymap = import ./utils/generateKeymap.nix;
in
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
      (generateKeymap ["n" "v"] "<C-y>" "\"+y")
    ];
  };
}
