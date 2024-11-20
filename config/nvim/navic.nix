{
  programs.nixvim.plugins.navic = {
    enable = true;
    settings = {
      click = true;
      highlight = true;
      lsp.autoAttach = true;
    };
  };
}
