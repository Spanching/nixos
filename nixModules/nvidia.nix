{config, pkgs, ... }:

{
  # Nvidia has unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true; # GL + Vulkan
  # hardware.graphics.enable32Bit = true; # GL + Vulkan

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = false;
  };
}
