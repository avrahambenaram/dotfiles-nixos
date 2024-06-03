let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim = {
    enableMan = true;
    globals.mapleader = " ";
    opts = {
      # Init
      number = true;
      relativenumber = true;
      numberwidth = 4;

      # Set tab size to 4 spaces
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;

      # Asks for saving file
      confirm = true;

      wrap = true;
      breakindent = true;
      colorcolumn = "100";

      cursorline = true;
      cursorlineopt = "both";

      scrolloff = 10;
    };
    keymaps = [
      (generateKeymap "v" "J" ":m '>+1<CR>gv=gv")
      (generateKeymap "v" "K" ":m '<-2<CR>gv=gv")
      (generateKeymap "n" "n" "nzzzv")
      (generateKeymap "n" "N" "Nzzzv")
      (generateKeymap "x" "<leader>p" "\"_dP")
    ];
  };
}
