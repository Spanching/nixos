{ pkgs, ... }:
{
  systemd.sockets.poweroff-listener = {
    description = "Shutdown trigger";
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenStream = "9999";
      Accept = true;
    };
  };

  systemd.services."poweroff-listener@" = {
    description = "Power off on request";
    serviceConfig = {
      Type = "oneshot";
      StandardInput = "socket";
      StandardOutput = "socket";
      ExecStart = pkgs.writeShellScript "poweroff-responder" ''
        printf 'HTTP/1.1 200 OK\r\nConnection: close\r\n\r\nshutting down\n'

        # ${pkgs.systemd}/bin/systemd-cat -t poweroff-listener echo "TRIGGERED"
        ${pkgs.systemd}/bin/systemctl --no-block poweroff
      '';
    };
  };
}
