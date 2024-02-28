{ config, pkgs, ... }:

let
  myDotNetEnv = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.dotnetCorePackages.runtime_8_0
    pkgs.dotnetCorePackages.aspnetcore_8_0
  ];
in
{
  home.packages = [
    myDotNetEnv
    pkgs.omnisharp-roslyn
  ];
  home.sessionPath = [
    "$HOME/.dotnet/tools"
  ];
  home.sessionVariables = {
    DOTNET_ROOT = "${myDotNetEnv}";
  };

  # Omnisharp config
  home.file.".omnisharp/omnisharp.json".source = ./dotnet/omnisharp.json;
}
