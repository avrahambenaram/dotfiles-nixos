{ config, pkgs, inputs, ... }:

{
  xdg.configFile."btop/themes/catppuccin-frappe.theme".source = inputs.catppuccin-btop + "/themes/catppuccin_frappe.theme";
}
