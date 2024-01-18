{
  programs.nixvim.plugins = {
    presence-nvim.enable = true;
    presence-nvim.buttons = [{
      label = "Github Profile";
      url = "https://github.com/avrahambenaram";
    }];
  };
}
