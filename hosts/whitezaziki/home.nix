{ inputs, pkgs, ... }:

{
  home.username = "andreas";
  home.homeDirectory = "/home/andreas";

  # Dotfile state version
  home.stateVersion = "26.11";

  imports = [
    ./../../homeModules
  ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;  # 0 = dark
      };

      userChrome = builtins.readFile "${inputs.catppuccin-zen}/themes/Frappe/Blue/userChrome.css";
      userContent = builtins.readFile "${inputs.catppuccin-zen}/themes/Frappe/Blue/userContent.css";
    };
  };

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
    jellyfin-media-player # depends on vulerable version of qtbrowser
    prismlauncher
    keepass
    heroic
    # openscad-unstable
    openscad
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
    arduino-ide
  ];

  home.pointerCursor.enable = true;

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "application/pdf" = "firefox.desktop";
  #     "application/x-extension-htm" = "firefox.desktop";
  #     "application/x-extension-html" = "firefox.desktop";
  #     "application/x-extension-shtml" = "firefox.desktop";
  #     "application/x-extension-xht" = "firefox.desktop";
  #     "application/x-extension-xhtml" = "firefox.desktop";
  #     "application/xhtml+xml" = "firefox.desktop";
  #     "image/jpeg" = "eog.desktop;";
  #     "image/png" = "eog-3.desktop;";
  #     "model/3mf" = "orca-slicer-3.desktop;";
  #     "model/stl" = "orca-slicer-4.desktop;";
  #     "text/html" = "firefox.desktop";
  #     "text/plain" = "nvim-2.desktop;";
  #     "video/mp4" = "mpv-3.desktop;";
  #     "x-scheme-handler/bruno" = "bruno.desktop";
  #     "x-scheme-handler/chrome" = "firefox.desktop";
  #     "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
  #     "x-scheme-handler/http" = "firefox.desktop";
  #     "x-scheme-handler/https" = "firefox.desktop";
  #     "x-scheme-handler/stabilitymatrix" = "stabilitymatrix.desktop";
  #   };
  # };

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
