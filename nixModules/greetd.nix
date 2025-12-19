{config, pkgs, ... }:

{
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "hyprland";
      user = "andreas";
    };
  };
}
