{
  wayland.windowManager.sway.config.window.commands = [
    {
      command = "floating enable";
      criteria = {
        app_id="^waydroid.";
      };
    }
    {
      command = "blur disable";
      criteria = {
        app_id="^waydroid.";
      };
    }
  ];
}
