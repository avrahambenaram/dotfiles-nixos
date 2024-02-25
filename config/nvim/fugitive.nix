let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins.fugitive.enable = true;
  programs.nixvim.keymaps = [
    (generateKeymap "n" "<leader>gg" ":Git<cr>")
    (generateKeymap "n" "<leader>gc" ":Git commit<cr>")
    (generateKeymap "n" "<leader>gp" ":Git push<cr>")
    (generateKeymap "n" "<leader>gP" ":Git pull<cr>")
    (generateKeymap "n" "<leader>gb" ":Git checkout")
  ];
}
