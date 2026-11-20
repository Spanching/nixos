{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixModules
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Hyprland binary cache
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  boot.kernelModules = [ "joydev" ];

  # make sure your user can read the device
  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="4f54", MODE="0660", GROUP="input", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="4f54", MODE="0660", GROUP="input", TAG+="uaccess"
  '';

  systemd.user.services.kursor-server = {
    description = "Kursor Server";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    path = [ pkgs.ydotool ];
    serviceConfig = {
      ExecStart = "/home/andreas/Projects/kursor_server/kursor_server";
      WorkingDirectory = "%h/Projects/kursor_server";
      Restart = "on-failure";
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # important on NixOS, see note below
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    config.hardware.nvidia.package
  ];
  programs.dconf.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  services.openssh.enable = true;
  services.xserver.enable = true;
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # Users
  users.users.andreas = {
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "docker"
      "wheel"
      "networkmanager"
      "kvm"
      "dialout"
      "tty"
      "ctbackup"
      "ydotool"
      "input"
      "dialout"
    ];
  };

  programs.ydotool.enable = true;

  # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  environment.systemPackages = with pkgs; [
    git
    tmux
    htop
    ctop
    wofi
    wl-clipboard
    wlroots
    xwayland
    wlr-randr
    wget
    docker
    kitty
    solaar
    nvidia-container-toolkit
    libnotify
    glib
    google-chrome
    unzip
    zip
    fd
    ripgrep
    eog
    ydotool
    uxplay
    evtest
    linuxConsoleTools # jstest
    jstest-gtk
    usbutils
  ];

  # Required for xdg-desktop-portal with home-manager
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
    "/share/thumbnailers"
  ];

  # System state
  system.stateVersion = "25.11";
}
