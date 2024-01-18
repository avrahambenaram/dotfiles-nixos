{
  programs.nixvim.plugins.comment-nvim = {
    enable = true;
    toggler = {
      block = "gc";
      line = "gcc";
    };
  };
}
