let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    disableNetrw = true;
    openOnSetup = true;
    git = {
      enable = true;
      ignore = false;
    };
  };
  programs.nixvim.keymaps = [
    (generateKeymap "n" "<leader>pv" ":NvimTreeToggle<CR>")
  ];
}
