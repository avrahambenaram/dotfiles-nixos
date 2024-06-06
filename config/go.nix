{ pkgs, ... }:

{
  home.packages = with pkgs; [
    air
    go
  ];
}
