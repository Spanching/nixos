{ config, pkgs, ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";

  # Dotfile state version
  home.stateVersion = "25.11";

  imports = [
    ./../../homeModules/hyprland.nix
    ./../../homeModules/waybar.nix
    ./../../homeModules/wofi.nix
    ./../../homeModules/tmux.nix
    ./../../homeModules/neovim.nix
  ];

  home.packages = with pkgs; [
    docker-compose
    bat
    delta
    firefox
    swaybg
    vscode-langservers-extracted
    # jellyfin-media-player depends on vulerable version of qtbrowser
    jetbrains.idea-ultimate
    claude-code
  ];

  catppuccin = {
    flavor = "frappe";
    fzf.enable = true;
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
    cursors = {
      enable = true;
      accent = "lavender";
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
      tabs.max_width = 250;
    };
    extraConfig = ''
      c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 5, 'right': 5}
    '';
  };

  programs.yazi.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Andreas";
      user.email = "andreas@kruck.cc";
      credential.helper = "store";
    };
  };

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

