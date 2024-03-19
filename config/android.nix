{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    androidenv.androidPkgs_9_0.androidsdk
  ];
  home.sessionVariables = {
    ANDROID_HOME = "${pkgs.androidenv.androidPkgs_9_0.androidsdk}/libexec/android-sdk";
  };
}
