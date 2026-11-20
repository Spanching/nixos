# This config solves a problem with solidcraft that allows to open dialogs and pickers

{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.hyprland = {
      default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };
}
