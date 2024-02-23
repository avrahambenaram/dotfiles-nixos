{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    package = pkgs.stable.alacritty;
    settings = {
      window.opacity = 0.8;
      font.family = "Fira Code";
      import = [
        "${config.xdg.configHome}/alacritty/theme.yml"
      ];
    };
  };
}
