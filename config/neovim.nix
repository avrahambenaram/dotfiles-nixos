{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # File navigation
      telescope-nvim
      harpoon
      nvim-tree-lua

      # Themes
      rose-pine
      dracula-nvim
      miasma-nvim
      catppuccino
      nord-nvim
      sonokai

      # Treesitter
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-dockerfile
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-json
        p.tree-sitter-toml
        p.tree-sitter-yaml
        p.tree-sitter-json
        p.tree-sitter-javascript
        p.tree-sitter-typescript
        p.tree-sitter-tsx
        p.tree-sitter-prisma
        p.tree-sitter-html
        p.tree-sitter-css
        p.tree-sitter-c-sharp
      ]))
      rainbow-delimiters-nvim

      # LSP
      lsp-zero-nvim
      lspkind-nvim
      nvim-lspconfig # Required
      mason-nvim # Optional
      mason-lspconfig-nvim # Optional
      nvim-cmp # Required
      cmp-nvim-lsp # Required
      luasnip # Required

      # Coding XP
      autoclose-nvim
      tabnine-vim
      nvim-comment
      trouble-nvim

      # Formatter
      formatter-nvim
      omnisharp-vim
      omnisharp-extended-lsp-nvim

      # Window additions
      lualine-nvim
      vim-visual-multi

      # Git integration
      vim-fugitive

      # Others
      nvim-highlight-colors
      vim-floaterm
      undotree
      nvim-web-devicons # Optional
      presence-nvim # Optional

      vim-nix
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/autoclose.lua}
      ${builtins.readFile ./nvim/colors.lua}
      ${builtins.readFile ./nvim/comment.lua}
      ${builtins.readFile ./nvim/floaterm.lua}
      ${builtins.readFile ./nvim/fugitive.lua}
      ${builtins.readFile ./nvim/harpoon.lua}
      ${builtins.readFile ./nvim/highlight.lua}
      ${builtins.readFile ./nvim/lsp.lua}
      ${builtins.readFile ./nvim/lualine.lua}
      ${builtins.readFile ./nvim/presence.lua}
      ${builtins.readFile ./nvim/tabnine.lua}
      ${builtins.readFile ./nvim/telescope.lua}
      ${builtins.readFile ./nvim/tree.lua}
      ${builtins.readFile ./nvim/treesitter.lua}
      ${builtins.readFile ./nvim/trouble.lua}
      ${builtins.readFile ./nvim/undo.lua}
    '';
    extraPackages = with pkgs; [
      ripgrep
      lua-language-server
      rnix-lsp

      xclip
    ];
  };
}
