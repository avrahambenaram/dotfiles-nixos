{
  programs.nixvim.plugins.lualine = {
    enable = true;
    theme = "jellybeans";
    globalstatus = true;
    winbar.lualine_c = [
      {
        name = "navic";
        extraConfig = {
          color_correction = "dynamic";
        };
      }
    ];
  };
}
