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
    cmp-buffer.enable = true;
    cmp-omni.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-zsh.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<C-Space>" = "cmp.mapping.complete()";
          "<Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if cmp.visible() then
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
            -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" })
          '';
          "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
          '';
        };
        sources = [
          { name = "cmp_tabnine"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "omni"; }
          { name = "zsh"; }
        ];
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
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require'lspconfig'.jdtls.setup {
  cmd = { '${pkgs.jdt-language-server}/bin/jdtls', '-data', '/home/avraham/.cache/jdtls/workspace/' }
}
  '';
}
