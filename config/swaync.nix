{ pkgs, ... }:

{
  services.swaync = {
    enable = true;
    settings = import ./swaync/config.nix { inherit pkgs; };
    style = ./swaync/style.css;
  };
}
