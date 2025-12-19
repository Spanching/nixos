{config, pkgs, ... }:

{
  imports = [
    ./catppuccin.nix
    ./nvidia.nix
    ./pipewire.nix
    ./font.nix
    ./docker.nix
    ./greetd.nix
  ];
}
