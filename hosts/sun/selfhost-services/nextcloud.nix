{
  pkgs,
  config,
  domain,
  ...
}:
{
  services.nextcloud = {
    enable = true;
    cli.memoryLimit = "2G";
    autoUpdateApps.enable = false;
    appstoreEnable = false;
    hostName = "nextcloud";
    datadir = "/var/lib/storage/nextcloud";
    home = "/var/lib/nextcloud";
    configureRedis = true;
    extraAppsEnable = true;
    https = true;
    maxUploadSize = "50G";
    package = pkgs.nextcloud32;
    caching = {
      memcached = true;
      redis = true;
      apcu = true;
    };
    settings = {
      overwriteProtocol = "https";
      trusted_proxies = [
        "localhost"
        "127.0.0.1"
      ];
      trusted_domains = [ "nextcloud.${domain}" ];
      defaultPhoneRegion = "BR";
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbname = "nextcloud";
      dbhost = "/run/postgresql";
      adminpassFile = "/etc/nextcloud-admin-pass";
      adminuser = "root";
    };
    poolSettings = {
      pm = "dynamic";
      "pm.max_children" = "500";
      "pm.start_servers" = "200";
      "pm.max_spare_servers" = "200";
      "pm.min_spare_servers" = "100";
      "pm.process_idle_timeout" = "3s";
    };
    phpOptions = {
      "opcache.enable" = 1;
      "opcache.memory_consumption" = 512;
      "opcache.interned_strings_buffer" = 32;
      "opcache.max_accelerated_files" = 10000;
      "opcache.revalidate_freq" = 1;
      "opcache.validate_timestamps" = 1;
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        bookmarks
        calendar
        contacts
        tasks
        ;
    };
  };

  systemd.services.nextcloud-scan = {
    description = "Nextcloud files scan";
    wantedBy = [ "timers.target" ];
    serviceConfig = {
      User = "nextcloud";
      ExecStart = "${config.services.nextcloud.occ}/bin/nextcloud-occ files:scan --all";
    };
  };
  systemd.timers."nextcloud-scan-timer" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "60m";
      OnUnitActiveSec = "60m";
      Unit = "nextcloud-scan.service";
    };
  };
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
  };
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
  environment.etc."nextcloud-admin-pass".text = "Agorajaera@123";
  environment.etc."nextcloud-whiteboard".text = "JWT_SECRET_KEY=Guigui@@@2035";
  environment.etc."onlyoffice-jwt".text = "JWT_SECRET_KEY=Guigui@@@2035";

  services.cron.enable = true;
  services.phpfpm.phpOptions = ''
    memory_limit = 2048M
    max_execution_time = 500
    opcache.enable = 1
    opcache.memory_consumption = 512
    opcache.interned_strings_buffer = 21
    opcache.max_accelerated_files = 10000
    opcache.revalidate_freq = 1
  '';
  system.activationScripts.metubePerms.text = ''
    mkdir -p  /var/lib/storage/nextcloud/data/guifuentes8@gmail.com/files/Youtube
    chown -R nextcloud:nextcloud  /var/lib/storage/nextcloud/data/guifuentes8@gmail.com/files/Youtube
    chmod 750 /var/lib/storage/nextcloud/data/guifuentes8@gmail.com/files/Youtube

  '';
}
