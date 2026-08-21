{ ... }:
{
  users.users.ctbackup = {
    isSystemUser = true;
    group = "ctbackup";
    uid = 990;
  };
  users.groups.ctbackup = {
    gid = 990;
  };

  fileSystems."/data".options = [
    "nofail"
    "uid=990"
    "gid=990"
    "umask=000"
    "big_writes"
  ];

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "security" = "user";
        "server min protocol" = "SMB3";
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
      };
      backups = {
        "path" = "/data/Backup/LXC";
        "valid users" = "ctbackup";
        "force user" = "ctbackup";
        "read only" = "no";
        "browseable" = "yes";
        "create mask" = "0660";
        "directory mask" = "0770";
      };
    };
  };
}
