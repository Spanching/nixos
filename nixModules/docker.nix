{config, pkgs, ... }:

{
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker.package = pkgs.docker_25;
  # virtualisation.docker.daemon.settings.features.cdi = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # daemon = {
    #   settings = {
    #     default-runtime = "nvidia";
    #   };
    # };
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    #   daemon.settings.features.cdi = true;
    # };
  };
}
