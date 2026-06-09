{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-thumbnailers
  ];

  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox";
    "image/png" = "eog";
  };
}
