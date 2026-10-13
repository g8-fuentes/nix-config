{ config, pkgs, ... }:

{
  programs.khal = {
    enable = true;

    settings.locale = {
      timeformat = "%H:%M";
      dateformat = "%d/%m/%Y";
      datetimeformat = "%d/%m/%Y %H:%M";
    };
  };

  programs.vdirsyncer = {
    enable = true;
    statusPath = "${config.home.homeDirectory}/.vdirsyncer/status";
  };

  accounts.calendar.accounts.g8 = {
    primary = true;

    khal.enable = false;
    vdirsyncer.enable = false;

    remote = {
      type = "caldav";
      url = "https://radicale.g8-space.com.br/guifuentes8%40gmail.com/3108ce27-61dc-42a6-aeb6-cdd4ec588deb/";
      userName = "guifuentes8@gmail.com";

      passwordCommand = [
        "cat"
        config.sops.secrets.caldav-password.path
      ];
    };

    local = {
      type = "filesystem";
      path = "${config.home.homeDirectory}/.calendars/g8";
      fileExt = ".ics";
    };
  };

  systemd.user.services.vdirsyncer-sync = {
    Unit = {
      Description = "vdirsyncer sync";
    };

    Service = {
      ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
    };
  };

  systemd.user.timers.vdirsyncer-sync = {
    Unit = {
      Description = "Run vdirsyncer every 10 minutes";
    };

    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "10m";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
