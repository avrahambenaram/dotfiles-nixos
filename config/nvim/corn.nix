{ config, pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    corn-nvim
  ];
  programs.nixvim.extraConfigLua = ''
require 'corn'.setup {
  border_style = "rounded",
  on_toggle = function(is_hidden)
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
  end,
}

-- ensure virtual_text diags are disabled
vim.diagnostic.config { virtual_text = false }
  '';
}
