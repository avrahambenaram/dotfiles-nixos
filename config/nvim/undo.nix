let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins.undotree = {
    enable = true;
    settings = {
      FocusOnToggle = true;
    };
  };
  programs.nixvim.keymaps = [
    (generateKeymap "n" "<leader>u" ":UndotreeToggle<CR>")
  ];
}
