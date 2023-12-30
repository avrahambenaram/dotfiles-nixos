{ inputs, config, pkgs, ... }:

{
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

    pkgs.nwg-look
	pkgs.swaylock-effects
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

  home.sessionPath = [
    "/home/avraham/Programs"
  ];
  home.shellAliases = {
    ls="ls --color=tty";
	ll="ls -Al";
	l="ls -l";
	weather="curl http://wttr.in";
	mkdir="mkdir -pv";
	nf="neofetch";
	vim="nvim";
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
	EDITOR="nvim";
	PF_INFO="ascii title os kernel de wm editor shell uptime pkgs memory palette";
  };

  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
	settings = {
	  window.opacity = 0.8;
	  font.family = "Fira Code";
	  import = [
	    "~/.config/alacritty/theme.yml"
	  ];
	};
  };

  programs.btop = {
    enable = true;
	settings = {
	  color_theme = "TTY";
	  vim_keys = true;
	};
  };

  programs.git = import ./.git.nix;
  programs.git-credential-oauth.enable = true;

  programs.gh.enable = true;

  programs.tmux = {
    enable = true;
	baseIndex = 1;
	mouse = true;
	prefix = "C-a";
	terminal = "screen-256color";
	extraConfig = ''
	unbind %
	bind | split-window -h

	unbind '"'
	bind - split-window -v

	unbind r
	bind r source-file ~/.tmux.conf
	
	bind -r j resize-pane -D 5
	bind -r k resize-pane -U 5
	bind -r l resize-pane -R 5
	bind -r h resize-pane -L 5
	'';
  };

  programs.zathura = {
    enable = true;
	extraConfig = ''
	  unmap f
	'';
	mappings = {
	  r = "reload";
	  p = "print";
	  f = "toggle_fullscreen";
	  R = "rotate";
	  "[fullscreen] f" = "toggle_fullscreen";
	};
	options = {
	  "selection-clipboard" = "clipboard";
	  font = "Fira Code";

	  # Open document in fit-width mode by default
	  "adjust-open" = "best-fit";

	  # search settings
	  "incremental-search" = true;

	  # padding
	  "statusbar-h-padding" = 0;
	  "statusbar-v-padding" = 0;
	};
  };

  programs.zsh = {
    enable = true;
	initExtra = "pfetch";
  };

  services.spotifyd = {
    enable = true;
	settings = import ./.spotifyd.nix;
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };

  gtk = {
	  enable = true;
	  theme = {
		package = pkgs.lounge-gtk-theme;
		name = "Lounge-night";
	  };

	  iconTheme = {
		package = pkgs.gnome.adwaita-icon-theme;
		name = "Adwaita";
	  };
  };
}
