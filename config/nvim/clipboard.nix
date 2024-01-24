{
  programs.nixvim.clipboard = {
    providers.xclip.enable = true;
    register = "unnamedplus";
  };
  programs.nixvim.keymaps = [
    {
      key = "<C-y>";
      action = "\"+y";
      options.silent = true;
    }
  ];
}
