# flake.nix

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim plugins
    corn-nvim.url = "github:RaafatTurki/corn.nvim";
    corn-nvim.flake = false;
    miasma-nvim.url = "github:xero/miasma.nvim";
    miasma-nvim.flake = false;
    rainglow.url = "github:rainglow/vim";
    rainglow.flake = false;
    vscode-nvim.url = "github:Mofiqul/vscode.nvim";
    vscode-nvim.flake = false;

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Btop
    catppuccin-btop.url = "github:catppuccin/btop";
    catppuccin-btop.flake = false;
  };

  outputs = { nixpkgs, nixpkgs-old, home-manager, nixvim, ... } @ inputs:
  let
    system = "x86_64-linux";
    overlay-old = final: prev: {
      old = nixpkgs-old.legacyPackages.${prev.system};
    };
  in
  {
    homeConfigurations."avraham@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;

          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-old ]; })

            nixvim.homeManagerModules.nixvim
            ./home.nix
          ];

          extraSpecialArgs = { inherit inputs; };
      };
  };
}
