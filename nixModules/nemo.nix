{ pkgs, ... }:
{
  
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    nemo
  ];

  services.gvfs.enable = true; # trash, mounting, network locations
  services.tumbler.enable = true; # Thumbnail service
}
