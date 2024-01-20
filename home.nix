{ config, pkgs, inputs, ... }:

let
  theme-switcher = import ./scripts/hypr/theme-switcher.nix { inherit pkgs; };
  myDotNetEnv = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnetCorePackages.sdk_6_0
    pkgs.dotnetCorePackages.runtime_6_0
    pkgs.dotnetCorePackages.aspnetcore_6_0
  ];
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./config/alacritty.nix
    ./config/btop.nix
    ./config/gtk.nix
    ./config/nixvim.nix
    ./config/nwg-bar.nix
    ./config/ranger.nix
    ./config/tmux.nix
    ./config/waybar.nix
    ./config/zathura.nix
    ./config/zsh.nix
  ];

  # Neovim
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          miasma-nvim = prev.vimUtils.buildVimPlugin {
            name = "miasma";
            src = inputs.miasma-nvim;
          };
        };
      })
    ];
  };

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
  home.packages = [
    pkgs.xfce.thunar

    # .NET
    myDotNetEnv

    pkgs.cliphist
    pkgs.hyprpicker
    pkgs.udiskie
    pkgs.swaynotificationcenter
    pkgs.swww
    pkgs.waybar
    pkgs.wl-clip-persist
    pkgs.wofi

    # Screenshot
    pkgs.grim
    pkgs.grimblast
    pkgs.sway-contrib.grimshot
    pkgs.slurp

    # Complementary Apps
    pkgs.nwg-look
    pkgs.nwg-bar
    pkgs.nwg-displays
    pkgs.wlr-randr
    pkgs.swaylock-effects

    # Neovim remote
    pkgs.neovim-remote

    # Night light
    pkgs.go-sct

    # Scripts
    theme-switcher
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
    PF_INFO="ascii title os kernel de wm editor shell uptime pkgs memory palette";
    DOTNET_ROOT = "${myDotNetEnv}";
  };

  programs.home-manager.enable = true;

  programs.git = import ./.git.nix;
  programs.git-credential-oauth.enable = true;

  programs.gh.enable = true;

  services.spotifyd = {
    enable = true;
    settings = import ./.spotifyd.nix;
  }; 
} 




