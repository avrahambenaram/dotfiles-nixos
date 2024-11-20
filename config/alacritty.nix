{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      import = [
        "${config.xdg.configHome}/alacritty/theme.toml"
      ];
    };
  };
}
