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

  xdg.mimeApps = {
    enable = true;
	defaultApplications = {
	  "text/html" = "vivaldi-stable.desktop";
	  "x-scheme-handler/http" = "vivaldi-stable.desktop";
	  "x-scheme-handler/https" = "vivaldi-stable.desktop";
	  "x-scheme-handler/about" = "vivaldi-stable.desktop";
	  "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
	};
  };
}
