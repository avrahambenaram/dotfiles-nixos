{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "auto";
        globalstatus = true;
        icons_enabled = true;
      };
      winbar.lualine_c = [
        "navic"
        {
          color_correction = "dynamic";
        }
      ];
    };
  };
}
