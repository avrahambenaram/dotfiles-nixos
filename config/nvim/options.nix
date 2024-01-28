{
  programs.nixvim = {
    enableMan = true;
    globals.mapleader = " ";
    options = {
      # Init
      number = true;
      relativenumber = true;
      numberwidth = 4;

      # Set tab size to 4 spaces
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      confirm = true;

      wrap = true;
      breakindent = true;
      colorcolumn = "80";

      cursorline = true;
      cursorlineopt = "both";

      scrolloff = 10;
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
