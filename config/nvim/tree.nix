{
  programs.nixvim.plugins.nvim-tree = {
    enable = true;
    disableNetrw = true;
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
