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
    rainglow.url = "github:rainglow/vim";
    rainglow.flake = false;
    vscode-nvim.url = "github:Mofiqul/vscode.nvim";
    vscode-nvim.flake = false;

    # Nixvim
    nixvim = {
      # url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-23.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, hy3, hycov, ... } @ inputs: {
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
                  hycov.packages.x86_64-linux.hycov
                  inputs.hyprland-plugins.packages.${nixpkgs.legacyPackages.x86_64-linux.system}.hyprtrails
                  inputs.hyprland-plugins.packages.${nixpkgs.legacyPackages.x86_64-linux.system}.hyprwinwrap
                ];
              };
            }
          ];

          extraSpecialArgs = { inherit inputs; };
      };
  };
}
