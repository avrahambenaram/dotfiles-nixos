{ config, pkgs, ... }:

let
  myDotNetEnv = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.dotnetCorePackages.runtime_8_0
    pkgs.dotnetCorePackages.aspnetcore_8_0
  ];
  unstable = import <nixpkgs-unstable> {};
in
{
  home.packages = [
    myDotNetEnv
    unstable.omnisharp-roslyn
  ];
  home.sessionPath = [
    "$HOME/.dotnet/tools"
  ];
  home.sessionVariables = {
    DOTNET_ROOT = "${myDotNetEnv}";
  };

  # Editor config
  home.file.".editorconfig".source = ./dotnet/.editorconfig;
  home.file.".omnisharp/omnisharp.json".source = ./dotnet/omnisharp.json;
}
