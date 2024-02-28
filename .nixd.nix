# .nixd.nix
{
  eval = {
    target = {
      args = [];
      installable = ".#homeConfigurations.avraham@nixos";
    };
    # Force thunks
    depth = 4;
  };
  formatting.command = "nixpkgs-fmt";
  options = {
    enable = true;
    target = {
      args = [ ];
      # home-manager configuration
      installable = ".#homeConfigurations.avraham@nixos.options";
    };
  };
}

