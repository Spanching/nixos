{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./../../nixModules
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
  networking = {
    hostName = "whitezaziki";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedUDPPorts = [ 9 ];
      # allowedTCPPortRanges = [{ from = 49152; to = 65535; }];
      # allowedUDPPortRanges = [{ from = 49152; to = 65535; }];
    };
    interfaces = {
      enp6s0 = {
        wakeOnLan.enable = true;
      };
    };
  };

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

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  services.openssh = {
    enable = true;
  };

  # Users
  users.users.andreas = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "wheel"
      "networkmanager"
    ];
  };

  services.xserver.enable = true;
  hardware.bluetooth.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb.overrideAttrs (old: {
      src = pkgs.fetchFromGitLab {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = "release_candidate_1.0rc2";
        sha256 = "sha256-jKAKdja2Q8FldgnRqOdFSnr1XHCC8eC6WeIUv83e7x4=";
      };
      patches = [ ];

      # Override the postPatch phase to handle the newer source structure
      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh

        # Only substitute if the pattern exists
        substituteInPlace scripts/build-udev-rules.sh \
          --replace-quiet '/bin/chmod' '${pkgs.coreutils}/bin/chmod' || true
      '';
      postInstall = ''
        ${old.postInstall or ""}
        # Fix any /usr/bin/env references in the generated udev rules
        substituteInPlace $out/lib/udev/rules.d/*.rules \
          --replace-quiet '/usr/bin/env' '${pkgs.coreutils}/bin/env' || true
      '';
    });
  };

  hardware.logitech.wireless.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

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
    pavucontrol
    docker
    kitty
    solaar
    nvidia-container-toolkit
  ];

  # Required for xdg-desktop-portal with home-manager
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # System state
  system.stateVersion = "25.11";
}
