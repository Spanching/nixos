{ pkgs, ... }:

{
  catppuccin = {
    autoEnable = true;
    enable = true;
    starship.enable = false;
    nvim.enable = false;
    hyprland.enable = false;
    hyprlock = {
      useDefaultConfig = false;
    };
    flavor = "frappe";
    cursors = {
      enable = true;
      accent = "lavender";
    };
  };

  # Theming for nemo file manager
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-frappe-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "frappe";
        accents = [ "blue" ];
      };
    };
  };

  home.sessionVariables.GTK_THEME = "catppuccin-frappe-blue-stanar";
}
