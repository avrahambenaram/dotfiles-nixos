{ config, pkgs, ... }:

{
  xdg.configFile."ranger/rc.conf".source = ./ranger/rc.conf;
}
