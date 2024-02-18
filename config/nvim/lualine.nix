{
  programs.nixvim.plugins.lualine = {
    enable = true;
    theme = "auto";
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
