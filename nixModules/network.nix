{ ... }:
{
  networking = {
    enableIPv6 = false;
    hostName = "whitezaziki";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedUDPPorts = [
        9
        1337
        53728
        53729
        53730
        33487
      ];
      allowedTCPPorts = [
        1337
        53728
        53729
        53730
        9999
        33487
      ];
      interfaces = {
        enp6s0 = {
          allowedTCPPorts = [ 9999 ];
        };
      };
    };
    interfaces = {
      enp6s0 = {
        wakeOnLan.enable = true;
      };
    };
  };
}
