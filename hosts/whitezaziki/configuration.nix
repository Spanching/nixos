{config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./../../nixModules
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader and EFI
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/EFI";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # Host & Networking
  networking.hostName = "whitezaziki";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Time and Locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Users
  users.users.andreas = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  services.xserver.enable = true;
  hardware.bluetooth.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    git tmux htop
    ctop wofi mako wl-clipboard
    wlroots xwayland
    wlr-randr
    wget pavucontrol
    docker kitty
  ];
  
  # Required for xdg-desktop-portal with home-manager
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # System state
  system.stateVersion = "25.11";
}

