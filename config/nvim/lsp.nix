{ pkgs, ... }:

let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.extraPackages = with pkgs; [
    lua-language-server
  ];
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    formatter-nvim
  ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        cssls.enable = true;
        eslint.enable = true;
        gopls = {
          enable = true;
          package = pkgs.gopls;
          settings = {
            completeUnimported = true;
            usePlaceholders = true;
            analyses = {
              unusedParams = true;
            };
          };
        };
        html.enable = true;
        htmx.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        nixd.enable = true;
        omnisharp = {
          enable = true;
          cmd = [
            "${pkgs.omnisharp-roslyn}/bin/OmniSharp"
            "DotNet:enablePackageRestore=true"
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
        };
        pylsp.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        tailwindcss.enable = true;
        taplo.enable = true;
        ts_ls.enable = true;
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
    lspsaga = {
      enable = true;
      lightbulb.enable = false;
    };
  };
  programs.nixvim.keymaps = [
    (generateKeymap "n" "K" ":Lspsaga hover_doc<CR>")
    (generateKeymap ["n" "v"] "ga" ":Lspsaga code_action<CR>")
    (generateKeymap ["n" "v"] "gR" ":Lspsaga rename<CR>")
  ];
  programs.nixvim.extraConfigLua = ''
  require'lspconfig'.jdtls.setup {
    cmd = { '${pkgs.jdt-language-server}/bin/jdtls', '-data', '/home/avraham/.cache/jdtls/workspace/' }
  }
  '';
}
