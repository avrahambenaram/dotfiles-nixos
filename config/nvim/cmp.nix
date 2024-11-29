let
  generateKeymap = import ./utils/generateKeymap.nix;
in
{
  programs.nixvim.plugins = {
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

    # Snippets
    cmp.settings.snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
    cmp_luasnip.enable = true;
    friendly-snippets.enable = true;
    luasnip.enable = true;
  };
  programs.nixvim.keymaps = [
    (generateKeymap ["i" "s"] "<C-n>" "<Plug>luasnip-next-choice")
    (generateKeymap ["i" "s"] "<C-p>" "<Plug>luasnip-prev-choice")
  ];
  programs.nixvim.extraConfigLua = ''
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  '';
}