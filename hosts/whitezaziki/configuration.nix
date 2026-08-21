{ pkgs, lib, ... }:

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

  programs.nix-ld.enable = true;
  programs.dconf.enable = true;

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
    ];
  };

  programs.ydotool.enable = true;

  # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  environment.systemPackages =
    with pkgs;
    [
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
      unzip
      zip
      fd
      ripgrep
      eog
      ydotool
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
