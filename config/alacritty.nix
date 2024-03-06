{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;
      import = [
        "${config.xdg.configHome}/alacritty/theme.toml"
      ];
    };
  };
}
