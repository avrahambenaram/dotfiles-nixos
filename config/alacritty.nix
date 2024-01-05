{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;
      font.family = "Fira Code";
      import = [
        "~/.config/alacritty/theme.yml"
      ];
    };
  };
}
