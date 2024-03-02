{ config, pkgs, ... }:

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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "inode/directory" = "Thunar.desktop";
    };
  };
}
