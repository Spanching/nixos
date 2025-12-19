{config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
    cursors = { 
      enable = true;
      accent = "lavender";
    }
  };

  # Bootloader and EFI
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
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

  # Enable docker
  virtualisation.docker = {
    enable = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };


  # Graphics + NVIDIA
  hardware.graphics.enable = true; # GL + Vulkan

  services.xserver.enable = true; # Needed for Xwayland & fallback
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true; # Use open kernel module if supported
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "river";
      user = "andreas";
    };
  };
  # PipeWire (audio + video)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    vim neovim git
    firefox
    tmux htop ripgrep fd
    ctop
    wofi mako wl-clipboard
    river wlroots xwayland
    gcc wget
    nerd-fonts.jetbrains-mono
    pavucontrol
    nodejs
    swaybg
    wlr-randr
    lazygit
    docker
    docker-compose
    jellyfin-media-player
    foot kitty
    miraclecast
  ];

  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Security
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # System state
  system.stateVersion = "25.05";
}

