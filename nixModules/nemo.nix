{ pkgs, ... }:
{
  
  environment.systemPackages = with pkgs; [
    nemo
  ];

  services.gvfs.enable = true; # trash, mounting, network locations
}
