{ config, pkgs, ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";

  # Dotfile state version
  home.stateVersion = "25.05";

  imports = [
    ./nixModules/river.nix
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
    firefox.enable = true;
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
    settings = {
      window_margin_width = "3 6 6 6";
      enable_audio_bell = false;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#whitezaziki";
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

