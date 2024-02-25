let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins.navbuddy = {
    enable = true;
    lsp.autoAttach = true;
  };
  programs.nixvim.keymaps = [
    (generateKeymap "n" "nb" ":Navbuddy<CR>")
  ];
}
