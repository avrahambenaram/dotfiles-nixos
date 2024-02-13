{ config, pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    formatter-nvim
  ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      onAttach = ''
      lsp.default_keymaps({buffer = bufnr})

      local opts = {buffer = bufnr, remap = false}
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      '';
      servers = {
        cssls.enable = true;
        eslint.enable = true;
        html.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        nixd.enable = true;
        omnisharp = {
          enable = true;
          cmd = [
            "${pkgs.omnisharp-roslyn}/bin/OmniSharp"
            "DotNet:enablePackageRestore=true"
            "FormattingOptions:OrganizeImports=true"
            "RoslynExtensionsOptions:EnableImportCompletion=true"
          ];
          onAttach.function = ''
          require'formatter'.setup({
            filetype = {
              csharp = {
                -- formatter setup
              }
            }
          })
          '';
          settings = {
            enableImportCompletion = true;
            organizeImportsOnFormat = true;
          };
        };
        prismals.enable = true;
        pylsp.enable = true;
        pyright.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        tailwindcss.enable = true;
        tsserver.enable = true;
        yamlls.enable = true;
      };
    };
    lspkind = {
      enable = true;
      cmp = {
        enable = true;
        ellipsisChar = "...";
        maxWidth = 50;
      };
    };
    cmp-buffer.enable = true;
    cmp-omni.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-zsh.enable = true;
    nvim-cmp = {
      enable = true;
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = false })";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
      };
      autoEnableSources = true;
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "omni"; }
        { name = "zsh"; }
      ];
    };
  };
  programs.nixvim.keymaps = [
    {
      key = "K";
      action = ":lua vim.lsp.buf.hover()<CR>";
      options.silent = true;
    }
  ];
}
