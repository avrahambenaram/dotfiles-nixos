{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
  ];
  xdg.configFile."ranger/rc.conf".source = ./ranger/rc.conf;
}
