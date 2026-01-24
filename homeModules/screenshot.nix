{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    swappy
    slurp
  ];
}
