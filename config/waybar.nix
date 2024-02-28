{ config, pkgs, ... }:

{
  imports = [
    ./waybar/config.nix
  ];

  programs.waybar = {
    enable = true;
    style = ./waybar/style.css;
  };
}
