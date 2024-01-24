{
  programs.nixvim.clipboard = {
    providers.xclip.enable = true;
    register = "unnamedplus";
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<C-y>y";
      action = "\"+yy";
      options.silent = true;
    }
    {
      mode = "v";
      key = "<C-y>";
      action = "\"+y<C-c>";
      options.silent = true;
    }
  ];
}
