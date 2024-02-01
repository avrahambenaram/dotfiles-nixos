{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    disableNetrw = true;
    git = {
      enable = true;
      ignore = false;
    };
  };
  programs.nixvim.keymaps = [
   {
      mode = "n";
      key = "<leader>pv";
      action = ":NvimTreeToggle<CR>";
      options.silent = true;
    }
  ];
}
