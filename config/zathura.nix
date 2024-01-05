{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      unmap f
    ''; 
    mappings = {
      r = "reload";
      p = "print";
      f = "toggle_fullscreen";
      R = "rotate";
      "[fullscreen] f" = "toggle_fullscreen";
    };
    options = {
      "selection-clipboard" = "clipboard";
      font = "Fira Code";
 
      # Open document in fit-width mode by default
      "adjust-open" = "best-fit";
 
      # search settings
      "incremental-search" = true;
 
      # padding 
      "statusbar-h-padding" = 0;
      "statusbar-v-padding" = 0;
    }; 
  }; 
}
