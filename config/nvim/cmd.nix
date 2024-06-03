{
  programs.nixvim.autoCmd = [
    {
      event = [ "BufWritePre" ];
      pattern = [ "*.go" ];
      command = "lua vim.lsp.buf.format()";
    }
  ];
}
