{ config, pkgs, ... }:

{
  imports = [
    ./nvim/autoclose.nix
    ./nvim/colors.nix
    ./nvim/comment.nix
    ./nvim/floaterm.nix
    ./nvim/fugitive.nix
    ./nvim/harpoon.nix
    ./nvim/highlight.nix
    ./nvim/lsp.nix
    ./nvim/lualine.nix
    ./nvim/options.nix
    ./nvim/presence.nix # Optional
    ./nvim/tabnine.nix
    ./nvim/telescope.nix
    ./nvim/tree.nix # Optional
    ./nvim/treesitter.nix
    ./nvim/trouble.nix
    ./nvim/undo.nix
  ];

  programs.nixvim.enable = true;
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    # Window additions
    vim-visual-multi

    # Others
    nvim-web-devicons # Optional
  ];
  programs.nixvim.extraPackages = with pkgs; [
    ripgrep
    lua-language-server
    rnix-lsp

    xclip
  ];
  programs.nixvim.plugins.nix.enable = true;
}
