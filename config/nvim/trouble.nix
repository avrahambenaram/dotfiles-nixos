{
  programs.nixvim.plugins.trouble.enable = true;
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>xw";
      action = ":lua (function() require('trouble').toggle('workspace_diagnostics') end)()<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>xd";
      action = ":lua (function() require('trouble').toggle('document_diagnostics') end)()<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = ":TroubleToggle quickfix<cr>";
      options.silent = true;
    }
  ];
}
