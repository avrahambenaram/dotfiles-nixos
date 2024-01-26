# Edit this configuration file to define what should be installed on
# toradmin@example.orgyour system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  unimatrix = import (builtins.fetchTarball "https://github.com/avrahambenaram/unimatrix/archive/master.tar.gz") {
    inherit pkgs;
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 15;
 

  # NUR
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Nix store
  nix.optimise.automatic = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";


  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
   
  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.avraham = {
    isNormalUser = true;
    description = "Avraham Ben Aram";
    extraGroups = [ "docker" "libvirtd" "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
  pkgs.alacritty
  pkgs.auto-cpufreq
  pkgs.brightnessctl
  pkgs.bash
  pkgs.btop
  pkgs.cava
  pkgs.calcurse
  pkgs.curl
  pkgs.discord
  pkgs.docker-compose
  pkgs.exfatprogs
  pkgs.eza
  pkgs.figma-linux
  pkgs.flatpak
  pkgs.gimp
  pkgs.gnome.nautilus
  pkgs.gparted
  pkgs.gzip
  pkgs.hollywood
  pkgs.htop
  pkgs.home-manager
  pkgs.imv
  pkgs.inkscape
  pkgs.insomnia
  pkgs.ly
  pkgs.lynx
  pkgs.nano
  pkgs.ncdu
  pkgs.neofetch
  pkgs.neovim
  pkgs.nurl
  pkgs.ntfs3g
  pkgs.obs-studio
  pkgs.openssl
  pkgs.p7zip
  pkgs.pavucontrol
  pkgs.pfetch
  pkgs.pipes
  pkgs.python3
  pkgs.qbittorrent
  pkgs.scrcpy
  pkgs.spotify
  pkgs.spotify-tui
  pkgs.spotifyd
  pkgs.steam-run
  pkgs.tor-browser-bundle-bin
  pkgs.tiv
  pkgs.tty-clock
  pkgs.tmux
  pkgs.unzip
  pkgs.uwufetch
  pkgs.vesktop
  pkgs.vimPlugins.packer-nvim
  pkgs.vivaldi
  pkgs.vlc
  pkgs.wget
  pkgs.wpsoffice
  pkgs.wtype
  pkgs.yt-dlp
  pkgs.zathura
  pkgs.zsh

  unimatrix
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "UbuntuMono" ]; })
    monocraft
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 25565 ];
  networking.firewall.allowedUDPPorts = [ 80 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # ZSH configuration
  programs.zsh = {
    enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "bira";
  };

  # Auto-cpufreq
  services.auto-cpufreq.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Spotifyd
  services.spotifyd.enable = true;

  # Hyprland
  xdg.portal.wlr.enable = true;
  programs.hyprland.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];

  # Tor
  services.tor = {
    enable = true;
    openFirewall = true;
    relay = {
      enable = true;
      role = "relay";
    };
    settings = {
      ContactInfo = "souzaavraham@gmail.com";
      Nickname = "Avraham";
      ORPort = 9001;
      ControlPort = 9051;
      BandWidthRate = "1 MBytes";
    };
  };

  security.pam.services.swaylock = {};

  # Virtualisation section
  virtualisation.waydroid.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "avraham" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

  virtualisation.hypervGuest.enable = true;
}
