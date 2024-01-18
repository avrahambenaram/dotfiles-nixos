{
  programs.nixvim = {
    enableMan = true;
    globals.mapleader = " ";
    options = {
      # Init
      number = true;
      relativenumber = true;

      # Set tab size to 4 spaces
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
    };
    keymaps = [
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }
      {
        mode = "x";
        key = "<leader>p";
        action = "\"_dP";
      }
    ];
  };
}
