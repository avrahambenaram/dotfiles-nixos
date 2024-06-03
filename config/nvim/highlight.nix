{ config, pkgs, ... }:

{
  programs.nixvim.extraPlugins = [pkgs.vimPlugins.nvim-highlight-colors];
  programs.nixvim.extraConfigLua = ''
    vim.o.termguicolors = true

    require("nvim-highlight-colors").setup {
        render = 'background',
        enable_named_colors = true,
        enable_tailwind = true,
    }
  '';
}
