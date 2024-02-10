{
  imports = [
    ./dap/node.nix
  ];

  programs.nixvim.plugins.dap = {
    enable = true;
    signs.dapBreakpoint.text = "🛑";
  };
  programs.nixvim.extraConfigLua = ''
  vim.g.dap_virtual_text = true
  vim.g.dap_virtual_text_show_scopes = true
  '';
  programs.nixvim.keymaps = [
    {
      mode = ["n"];
      key = "<leader>dr";
      action = ":DapToggleRepl<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>db";
      action = ":DapToggleBreakpoint<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F3>";
      action = ":DapContinue<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F4>";
      action = ":DapStepOver<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F10>";
      action = ":lua require'dap'.step_back()<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F11>";
      action = ":DapStepInto<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<F12>";
      action = ":DapStepOut<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>dt";
      action = ":DapTerminate<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>ds";
      action = ":lua require'dap.ui.widgets'.sidebar(require'dap.ui.widgets'.scopes).open()<CR>";
      options.silent = true;
    }
    {
      mode = ["n"];
      key = "<leader>dh";
      action = ":lua require'dap.ui.widgets'.hover()<CR>";
      options.silent = true;
    }
  ];
}
