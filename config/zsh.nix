{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = "pfetch";
  }; 
  home.packages = with pkgs; [
    pfetch
  ];
}
