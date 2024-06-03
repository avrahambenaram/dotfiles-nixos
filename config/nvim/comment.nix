{
  programs.nixvim.plugins.comment = {
    enable = true;
    settings.toggler = {
      block = "gc";
      line = "gcc";
    };
  };
}
