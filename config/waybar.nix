{ config, pkgs, ... }:

{
  imports = [
    ./waybar/config.nix
  ];

  programs.waybar.enable = true;
  programs.waybar.style = ./waybar/style.css;
}
