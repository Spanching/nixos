{ pkgs, ... }:
{
  
  environment.systemPackages = with pkgs; [
    nemo
  ];

  services.gvfs.enable = true; # trash, mounting, network locations
  services.tumbler.enable = true; # Thumbnail service
}
