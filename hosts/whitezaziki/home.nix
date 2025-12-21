{ config, pkgs, ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";

  # Dotfile state version
  home.stateVersion = "25.11";

  imports = [
    ./../../homeModules
  ];

  home.packages = with pkgs; [
    docker-compose
    firefox
    swaybg
    vscode-langservers-extracted
    # jellyfin-media-player depends on vulerable version of qtbrowser
    jetbrains.idea-ultimate
    claude-code
  ];

  programs.bat = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.yazi.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      size = 12;
      name = "JetBrainsMono";
    };
    settings = {
      window_margin_width = "3 6 6 6";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      nnix = "nvim /etc/nixos";
      confedit = "sudo -E -s nvim /etc/nixos/configuration.nix";
      snvim = "sudo -E -s nvim";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # Notifications
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      border-color = "#89b4fa";
      font = "JetBrainsMono Nerd Font 12";
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
    };
  };

  programs.home-manager.enable = true;
}
