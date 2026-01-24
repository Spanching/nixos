{ ... }:

{
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "start-hyprland";
      user = "andreas";
    };
  };
}
