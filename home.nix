{ config, pkgs, inputs, ... }:

let
  theme-switcher = import ./scripts/hypr/theme-switcher.nix { inherit config; inherit pkgs; };
  bg-cycle = import ./scripts/hypr/bg-cycle.nix { inherit config; inherit pkgs; };

  postman = pkgs.callPackage ./pkgs/postman { };
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./config/alacritty.nix
    ./config/dotnet.nix
    ./config/gtk.nix
    ./config/nixpkgs.nix
    ./config/nixvim.nix
    ./config/nwg-bar.nix
    ./config/ranger.nix
    ./config/tmux.nix
    ./config/waybar.nix
    ./config/wofi.nix
    ./config/zathura.nix
    ./config/zsh.nix
    ./hypr
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    xfce.thunar

    cliphist
    udiskie
    swaynotificationcenter
    swww
    waybar
    wl-clipboard
    wl-clip-persist
    wofi
    nur.repos.avrahambenaram.hyprpicker

    # Screenshot
    grim
    grimblast
    sway-contrib.grimshot
    slurp

    # Complementary Apps
    nwg-look
    nwg-bar
    nwg-displays
    wlr-randr
    swaylock-effects

    # Neovim remote
    neovim-remote

    # Night light
    go-sct

    # Scripts
    theme-switcher
    bg-cycle

    postman
    maven
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/avraham/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.

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

    # Neovim
    vi="nvim --listen /tmp/nvimsocket";
    vim="nvim --listen /tmp/nvimsocket";
  };
  home.sessionVariables = {
    BROWSER="vivaldi";
    EDITOR="nvim";
    PF_INFO="ascii title os kernel de wm editor shell uptime pkgs memory palette";
  };

  programs.home-manager.enable = true;

  programs.git = import ./.git.nix;
  programs.git-credential-oauth.enable = true;

  programs.gh.enable = true;

  services.spotifyd = {
    enable = true;
    settings = import ./.spotifyd.nix;
  }; 

  xdg.enable = true;
} 




