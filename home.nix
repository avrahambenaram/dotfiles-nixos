{ config, pkgs, inputs, ... }:

let
  swayfader = pkgs.callPackage ./pkgs/swayfader {};
  fzfind = import ./config/scripts/fzfind.nix { inherit pkgs; };
  fzfindt = import ./config/scripts/fzfindt.nix { inherit pkgs; };
in 
{
  imports = [
    ./config/alacritty.nix
    ./config/btop.nix
    ./config/dotnet.nix
    ./config/editorconfig.nix
    ./config/git.nix
    ./config/gtk.nix
    ./config/nixpkgs.nix
    ./config/nixvim.nix
    ./config/nwg-bar.nix
    ./config/ranger.nix
    ./config/spotifyd.nix
    ./config/sway.nix
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
        corn-nvim = prev.vimUtils.buildVimPlugin {
          name = "corn";
          src = inputs.corn-nvim;
        };
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

    maven
    swayfader
    fzfind
    fzfindt
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
    BROWSER="firefox";
    PF_INFO="ascii title os kernel de wm editor shell uptime pkgs memory palette";
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  programs.home-manager.enable = true;

  xdg.enable = true;
} 




