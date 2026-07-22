{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
  hardware.nvidia.prime = {
    offload.enable = true;
    # you'll need to fill these in from lspci
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:19:0:0";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = false;
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "quiet"
  ];
}
