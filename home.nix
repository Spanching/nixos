{ config, pkgs, ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";

  # Dotfile state version
  home.stateVersion = "25.05";

  imports = [
    ./nixModules/river.nix
    ./nixModules/waybar.nix
  ];

  home.packages = with pkgs; [
    docker
  ];

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;
    extraConfig = ''
      import os
      from urllib.request import urlopen

      # load your autoconfig, use this, if the rest of your config is empty!
      config.load_autoconfig()

      if not os.path.exists(config.configdir / "theme.py"):
        theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
        with urlopen(theme) as themehtml:
          with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

      if os.path.exists(config.configdir / "theme.py"):
        import theme
        theme.setup(c, 'frappe', True)
    '';
  };

  # Programs managed by home-manager
  programs.git = {
    enable = true;
    userName = "Andreas";
    userEmail = "andreas@kruck.cc";
    extraConfig = {
      credential.helper = "store";
    };
  };

  programs.alacritty = {
    enable = true;
    theme = "catppuccin_frappe";
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

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      confedit = "sudo -E -s nvim /etc/nixos/configuration.nix";
      snvim = "sudo -E -s nvim";
    };
  };

  programs.tmux.enable = true;

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

