{ pkgs }:

{
  gtk = { 
      enable = true;
      theme = {
        package = pkgs.lounge-gtk-theme;
        name = "Lounge-night";
      }; 
 
      iconTheme = { 
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      }; 
  }; 
}
