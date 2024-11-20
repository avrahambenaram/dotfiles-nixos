{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      highlight.enable = true;
      indent.enable = true;
    };
  };
  programs.nixvim.plugins.rainbow-delimiters.enable = true;
}
