{ pkgs, ... }:

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
    vscode-langservers-extracted
    spotify
    discord
    mpv
    cliphist
    bluetui
    bemoji
    jq
    youtube-tui
    yt-dlp
    pulsemixer
    pamixer
    # jellyfin-media-player depends on vulerable version of qtbrowser
    prismlauncher
    keepass
    heroic
    openscad-unstable
    (pkgs.runCommand "orca-slicer-wrapped" { buildInputs = [ pkgs.makeWrapper ]; } ''
      makeWrapper ${pkgs.orca-slicer}/bin/orca-slicer $out/bin/orca-slicer \
        --set __GLX_VENDOR_LIBRARY_NAME nvidia \
        --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json \
        --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib \
        --set FC_DEBUG 1 \
        --set GDK_BACKEND x11 \
        --set ORCA_SLICER_SINGLE_CONTEXT 1 \
        --unset MESA_LOADER_DRIVER_OVERRIDE \
        --unset GALLIUM_DRIVER
    '')
    # orca-slicer
  ];

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        useGrimAdapter = true;
        disabledGrimWarning = true;
        disabledTrayIcon = true;
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.yazi}/bin/yazi";
      };
    };
  };

  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    # enableFishIntegration = true;
  };

  services.playerctld.enable = true;

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
      ns = "nix-shell -p";
      nnix = "nvim /etc/nixos";
      confedit = "sudo -E -s nvim /etc/nixos/configuration.nix";
      svim = "sudo -E -s nvim";
      bm = "cd ~/Projects/BundesMenschen";
      vs = "bm && cd voting-service";
      dc = "bm && cd democracy_check";
      nd = "nix develop";
      ndc = "nix develop --command";
      ndi = "nix develop --command idea";
      nda = "nix develop --command android-studio";
      vpnup = "sudo systemctl start openvpn-nordvpn.service";
      vpndown = "sudo systemctl stop openvpn-nordvpn.service";
      tvup = "hyprctl keyword monitor HDMI-A-1,3840x2160@60,-1280x0,3";
      tvdown = "hyprctl keyword monitor HDMI-A-1,disable";
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
      margin = 9;
      border-radius = 10;
    };
  };

  programs.home-manager.enable = true;
}
