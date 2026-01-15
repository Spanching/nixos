{ ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
    };
  };

  accounts.email = {
    accounts.andreas_kruck = {
      address = "andreas_kruck@web.de";
      realName = "Andreas Kruck";

      # IMAP settings for web.de
      imap = {
        host = "imap.web.de";
        port = 993;
        tls.enable = true;
      };

      # SMTP settings for web.de
      smtp = {
        host = "smtp.web.de";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };

      userName = "andreas_kruck@web.de";
      primary = true;
    };

    accounts.akruck97 = {
      address = "akruck97@web.de";
      realName = "Andreas";

      # IMAP settings for web.de
      imap = {
        host = "imap.web.de";
        port = 993;
        tls.enable = true;
      };

      # SMTP settings for web.de
      smtp = {
        host = "smtp.web.de";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };

      userName = "akruck97@web.de";
      primary = false;
    };
  };
}
