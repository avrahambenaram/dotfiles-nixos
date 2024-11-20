{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      general.import = [
        "${config.xdg.configHome}/alacritty/theme.toml"
      ];
    };
  };
}
