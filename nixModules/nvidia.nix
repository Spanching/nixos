{config, pkgs, ... }:

{
  # Nvidia has unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true; # GL + Vulkan

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
