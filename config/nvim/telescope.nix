{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extraOptions = {
      defaults = {
        file_ignore_paterns = ["node_modules" "dist"];
      };
    };
    keymaps = {
      # File navigation
      "<C-p>" = "git_files";
      "<leader>pf" = "find_files";
      "<leader>ps" = "live_grep";

      # Lsp
      "gd" = "lsp_definitions";
      "gr" = "lsp_references";

      # Colorscheme
      "sp" = "colorscheme";
    };
  };
}
