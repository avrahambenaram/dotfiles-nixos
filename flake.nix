# flake.nix

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # or "github:hyprwm/Hyprland?ref=v{version}" for a release version of hyprland

    hy3 = {
      url = "github:outfoxxed/hy3";
      # or "github:outfoxxed/hy3?ref=hl{version}" for a release version of hyprland
      inputs.hyprland.follows = "hyprland";
    };

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    # Neovim plugins
    miasma-nvim.url = "github:xero/miasma.nvim";
    miasma-nvim.flake = false;
    omnisharp-vim.url = "github:OmniSharp/omnisharp-vim";
    omnisharp-vim.flake = false;
  };

  outputs = { nixpkgs, home-manager, hyprland, hy3, hycov, ... } @ inputs: {
    homeConfigurations."avraham@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          modules = [
            ./home.nix
            ./hypr/clipboard.nix
            ./hypr/input.nix
            ./hypr/keybindings.nix
            ./hypr/misc.nix
            ./hypr/mount.nix
            ./hypr/night-light.nix
            ./hypr/notification.nix
            ./hypr/xwayland.nix
            hyprland.homeManagerModules.default

            {
              wayland.windowManager.hyprland = {
                enable = true;
                xwayland.enable = true;
                plugins = [
                  hy3.packages.x86_64-linux.hy3
                  hycov.packages.x86_64-linux.hycov
                  inputs.hyprland-plugins.packages.${nixpkgs.legacyPackages.x86_64-linux.system}.hyprtrails
                  inputs.hyprland-plugins.packages.${nixpkgs.legacyPackages.x86_64-linux.system}.hyprwinwrap
                ];
                settings = {
                  source = [
                    "~/.config/hypr/theme.conf"
                    "~/.config/hypr/monitors.conf"
                  ];
                  "exec-once" = [
                    "touch ~/.config/hypr/monitors.conf"
                  ];
                };
              };
            }
          ];

          extraSpecialArgs = { inherit inputs; };
      };
  };
}
