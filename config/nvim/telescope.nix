{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extraOptions = {
      defaults = {
        file_ignore_paterns = ["node_modules" "dist"];
      };
    };
    keymaps = {
      "<C-p>" = "git_files";
      "<leader>pf" = "find_files";
      "<leader>ps" = "live_grep";
    };
  };
}
