{ config, pkgs, ... }:

let
  nvimRemote = "nvim --listen /tmp/nvimsocket";
in 
{
  imports = [
    ./nvim/autoclose.nix
    ./nvim/clipboard.nix
    ./nvim/cmd.nix
    ./nvim/cmp.nix
    ./nvim/colors.nix
    ./nvim/comment.nix
    ./nvim/corn.nix
    ./nvim/dap.nix
    ./nvim/floaterm.nix
    ./nvim/fugitive.nix
    ./nvim/harpoon.nix
    ./nvim/highlight.nix
    ./nvim/lsp.nix
    ./nvim/lualine.nix
    ./nvim/navbuddy.nix
    ./nvim/navic.nix
    ./nvim/neotest.nix
    ./nvim/options.nix
    ./nvim/presence.nix # Optional
    ./nvim/tabnine.nix
    ./nvim/telescope.nix
    ./nvim/tree.nix # Optional
    ./nvim/treesitter.nix
    ./nvim/trouble.nix
    ./nvim/undo.nix
  ];

  home.shellAliases = {
    vi = nvimRemote;
    vim = nvimRemote;
  };
  home.sessionVariables = {
    EDITOR="nvim";
  };
  home.packages = with pkgs; [
    neovim-remote
  ];

  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      # Window additions
      vim-visual-multi
    ];
    plugins.nix.enable = true;
    plugins.web-devicons.enable = true;
  };
}
