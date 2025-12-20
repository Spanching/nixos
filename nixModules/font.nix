{config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
