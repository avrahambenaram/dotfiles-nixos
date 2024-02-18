{
  programs.nixvim.plugins.navbuddy = {
    enable = true;
    lsp.autoAttach = true;
  };
  programs.nixvim.keymaps = [
    {
      key = "nb";
      action = ":Navbuddy<CR>";
      options.silent = true;
    }
  ];
}
