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
  };

  outputs = { nixpkgs, home-manager, hyprland, hy3, ... } @ inputs: {
    homeConfigurations."avraham@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          modules = [
            ./home.nix
            hyprland.homeManagerModules.default

            {
              wayland.windowManager.hyprland = {
                enable = true;
                xwayland.enable = true;
                plugins = [
                  hy3.packages.x86_64-linux.hy3
                  inputs.hyprland-plugins.packages.${nixpkgs.legacyPackages.x86_64-linux.system}.hyprtrails
                  inputs.hyprland-plugins.packages.${nixpkgs.legacyPackages.x86_64-linux.system}.hyprwinwrap
                ];
              };
              wayland.windowManager.hyprland.settings = {
                source = "~/.config/hypr/index.conf";
              };
            }
          ];
      };
  };
}
