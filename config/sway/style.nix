{
  wayland.windowManager.sway.config = {
    gaps = {
      inner = 2;
      outer = 8;
    };
    fonts = {
      names = ["Fira Code" "Noto Sans"];
      style = "Regular Semi-Bold";
      size = 10.0;
    };
  };
  wayland.windowManager.sway.extraConfig = ''
blur enable
blur_xray false

shadows enable
shadow_blur_radius 10
shadow_color #0000007F

corner_radius 10
  '';
}
