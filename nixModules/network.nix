{ ... }:
{
  networking = {
    enableIPv6 = false;
    hostName = "whitezaziki";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedUDPPorts = [ 9 ];
    };
    interfaces = {
      enp6s0 = {
        wakeOnLan.enable = true;
      };
    };
  };
}
