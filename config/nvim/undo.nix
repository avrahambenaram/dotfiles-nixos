{
  programs.nixvim.plugins.undotree = {
    enable = true;
    focusOnToggle = true;
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>u";
      action = ":UndotreeToggle<CR>";
      options.silent = true;
    }
  ];
}
