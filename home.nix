{ config, pkgs, ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";

  # Dotfile state version
  home.stateVersion = "25.05";

  imports = [
    # ./nixModules/river.nix
    ./nixModules/hyprland.nix
    ./nixModules/waybar.nix
    ./nixModules/wofi.nix
    ./nixModules/tmux.nix
  ];

  home.packages = with pkgs; [
    docker-compose
    bat
    delta
  ];

  catppuccin = {
    flavor = "frappe";
    bat.enable = true;
    kitty.enable = true;
    qutebrowser.enable = true;
    yazi.enable = true;
    tmux = { 
      enable = true;
      extraConfig = ''
        set -g @catppuccin_window_status_style "rounded"

        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
      '';
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;
    settings = {
      colors.webpage.darkmode.enabled = true;
    };
  };

  programs.yazi.enable = true;

  programs.git = {
    enable = true;
    userName = "Andreas";
    userEmail = "andreas@kruck.cc";
    extraConfig = {
      credential.helper = "store";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
    ];
    extraPackages = with pkgs; [
      tree-sitter
    ];
  };

  programs.kitty = {
    enable = true;
    font = {
      size = 12;
      name = "JetBrainsMono";
    };
    # themeFile = "Catppuccin-Frappe";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      confedit = "sudo -E -s nvim /etc/nixos/configuration.nix";
      snvim = "sudo -E -s nvim";
    };
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

