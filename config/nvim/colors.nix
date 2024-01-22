{ config, pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    dracula-nvim
    miasma-nvim
    nord-nvim
    rainglow
    rose-pine
    sonokai
  ];

  programs.nixvim.extraConfigLuaPre = ''
    function ColorMyPencils(color)
        local home = os.getenv("HOME")
        local themeFile = io.open(home .. "/.nvimtheme", "r")
        color = color or themeFile:read('*all') or "rose-pine"
        themeFile:close()

        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

    ColorMyPencils()
  '';
}
