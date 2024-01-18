{
  programs.nixvim.plugins.fugitive.enable = true;
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = ":Git<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gc";
      action = ":Git commit<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = ":Git push<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gP";
      action = ":Git pull<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = ":Git checkout";
    }
  ];
}
