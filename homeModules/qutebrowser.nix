{ ... }:

{
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;
    settings = {
      colors.webpage.darkmode.enabled = true;
      tabs.max_width = 250;
    };
    extraConfig = ''
      c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 5, 'right': 5}
    '';
  };
}
