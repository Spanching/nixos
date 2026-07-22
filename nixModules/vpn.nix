{ ... }:
{
  services.tailscale = {
    enable = true;
  };

  services.openvpn.servers = {
    nordvpn = {
      autoStart = false;
      authUserPass = {
        username = "PJmQUJZrn1csoQYDzjPgKJSh";
        password = "TnWfUxLkzKQzH5oopphM6LKP";
      };
      config = "config /home/andreas/Downloads/at89.nordvpn.com.tcp.ovpn";
      updateResolvConf = true;
    };
  };

}
