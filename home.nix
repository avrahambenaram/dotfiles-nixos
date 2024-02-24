{ config, pkgs, inputs, ... }:

let
  theme-switcher = import ./config/hypr/scripts/theme-switcher.nix { inherit config; inherit pkgs; };
  bg-cycle = import ./config/hypr/scripts/bg-cycle.nix { inherit config; inherit pkgs; };

  postman = pkgs.callPackage ./pkgs/postman { };
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./config/alacritty.nix
    ./config/dotnet.nix
    ./config/git.nix
    ./config/gtk.nix
    ./config/hypr.nix
    ./config/nixpkgs.nix
    ./config/nixvim.nix
    ./config/nwg-bar.nix
    ./config/ranger.nix
    ./config/spotifyd.nix
    ./config/tmux.nix
    ./config/waybar.nix
    ./config/wofi.nix
    ./config/zathura.nix
    ./config/zsh.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Unfree
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "tabnine"
  ];

  # Neovim
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        miasma-nvim = prev.vimUtils.buildVimPlugin {
          name = "miasma";
          src = inputs.miasma-nvim;
        };
        rainglow = prev.vimUtils.buildVimPlugin {
          name = "rainglow";
          src = inputs.rainglow;
        };
        vscode-nvim = prev.vimUtils.buildVimPlugin {
          name = "vscode";
          src = inputs.vscode-nvim;
        };
      };
    })
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "avraham";
  home.homeDirectory = "/home/avraham";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    xfce.thunar

    swww
    wofi
    nur.repos.avrahambenaram.hyprpicker

    # Scripts
    theme-switcher
    bg-cycle

    postman
    maven
  ];

  home.shellAliases = {
    ls="ls --color=tty";
    ll="ls -Alh";
    l="ls -lh";
    weather="curl http://wttr.in";
    mkdir="mkdir -pv";
    nf="neofetch";
    lyricstifyS="lyricstify start --highlight-markup \"^m\"";

    # Waydroid
    waydroidStart="sudo modprobe binder_linux && sudo waydroid container start && waydroid session start";
    waydroidStop="waydroid session stop && sudo waydroid container stop";
    waydroidRotation="sudo waydroid shell wm set-user-rotation lock";
    waydroidWidth="waydroid prop set persist.waydroid.width";
    waydroidHeight="waydroid prop set persist.waydroid.height";
  };
  home.sessionVariables = {
    BROWSER="vivaldi";
    PF_INFO="ascii title os kernel de wm editor shell uptime pkgs memory palette";
  };

  programs.home-manager.enable = true;

  xdg.enable = true;
} 




