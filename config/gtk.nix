{ pkgs, ... }:

{
  gtk = { 
      enable = true;
      theme = {
        package = pkgs.lounge-gtk-theme;
        name = "Lounge-night";
      }; 
 
      iconTheme = { 
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      }; 
  }; 

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "inode/directory" = "Thunar.desktop";
    };
  };
}
