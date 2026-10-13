{ pkgs, lib, config, ... }:
let domain = "postiz.larquim.com.br";
in {
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };

  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers."postiz" = {
    image = "ghcr.io/gitroomhq/postiz-app:latest";
    environmentFiles = [ "/run/postiz.env" ];
    environment = {
      "BACKEND_INTERNAL_URL" = "http://localhost:3000";
      "DISABLE_REGISTRATION" = "true";
      "FRONTEND_URL" = "https://${domain}";
      "IS_GENERAL" = "true";
      "MAIN_URL" = "https://${domain}";
      "NEXT_PUBLIC_BACKEND_URL" = "https://${domain}/api";
      "NEXT_PUBLIC_UPLOAD_DIRECTORY" = "/uploads";
      "UPLOAD_DIRECTORY" = "/uploads";
      "NTBA_FIX_350" = "1";
      "REDIS_URL" = "redis://postiz-redis:6379";
      "STORAGE_PROVIDER" = "local";
    };
    volumes = [
      "postiz_postiz-config:/config:rw"
      "/var/lib/storage/postiz/uploads:/uploads:rw"
    ];
    ports = [ "5000:5000/tcp" ];
    dependsOn = [ "postiz-postgres" "postiz-redis" ];
    log-driver = "journald";
    extraOptions =
      [ "--network-alias=postiz" "--network=postiz_postiz-network" ];
  };
  systemd.services."podman-postiz" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [
      "podman-network-postiz_postiz-network.service"
      "podman-volume-postiz_postiz-config.service"
      "podman-volume-postiz_postiz-uploads.service"
    ];
    requires = [
      "podman-network-postiz_postiz-network.service"
      "podman-volume-postiz_postiz-config.service"
      "podman-volume-postiz_postiz-uploads.service"
    ];
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };
  virtualisation.oci-containers.containers."postiz-postgres" = {
    image = "postgres:17-alpine";
    environmentFiles = [ "/run/postiz.env" ];

    volumes = [ "postiz_postgres-volume:/var/lib/postgresql/data:rw" ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=pg_isready -U $POSTGRES_USER -d $POSTGRES_DB"
      "--health-interval=10s"
      "--health-retries=3"
      "--health-timeout=3s"
      "--network-alias=postiz-postgres"
      "--network=postiz_postiz-network"
    ];
  };
  systemd.services."podman-postiz-postgres" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [
      "podman-network-postiz_postiz-network.service"
      "podman-volume-postiz_postgres-volume.service"
    ];
    requires = [
      "podman-network-postiz_postiz-network.service"
      "podman-volume-postiz_postgres-volume.service"
    ];
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };
  virtualisation.oci-containers.containers."postiz-redis" = {
    image = "redis:7.2";
    volumes = [ "postiz_postiz-redis-data:/data:rw" ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=redis-cli ping"
      "--health-interval=10s"
      "--health-retries=3"
      "--health-timeout=3s"
      "--network-alias=postiz-redis"
      "--network=postiz_postiz-network"
    ];
  };
  systemd.services."podman-postiz-redis" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [
      "podman-network-postiz_postiz-network.service"
      "podman-volume-postiz_postiz-redis-data.service"
    ];
    requires = [
      "podman-network-postiz_postiz-network.service"
      "podman-volume-postiz_postiz-redis-data.service"
    ];
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };

  systemd.services."podman-network-postiz_postiz-network" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f postiz_postiz-network";
    };
    script = ''
      podman network inspect postiz_postiz-network || podman network create postiz_postiz-network
    '';
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };

  systemd.services."podman-volume-postiz_postgres-volume" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect postiz_postgres-volume || podman volume create postiz_postgres-volume
    '';
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };
  systemd.services."podman-volume-postiz_postiz-config" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect postiz_postiz-config || podman volume create postiz_postiz-config
    '';
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };
  systemd.services."podman-volume-postiz_postiz-redis-data" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect postiz_postiz-redis-data || podman volume create postiz_postiz-redis-data
    '';
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };
  systemd.services."podman-volume-postiz_postiz-uploads" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman volume inspect postiz_postiz-uploads || podman volume create postiz_postiz-uploads
    '';
    partOf = [ "podman-compose-postiz-root.target" ];
    wantedBy = [ "podman-compose-postiz-root.target" ];
  };

  systemd.targets."podman-compose-postiz-root" = {
    unitConfig = { Description = "Root target generated by compose2nix."; };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services."generate-postiz-env" = {
    wantedBy = [ "multi-user.target" ];
    before = [ "podman-postiz.service" ];
    script = ''

      JWT=$(cat ${config.sops.secrets."postiz-jwt".path})
      DB=$(cat ${config.sops.secrets."postiz-db".path})
      USER=$(cat ${config.sops.secrets."postiz-db-user".path})
      PASSWORD=$(cat ${config.sops.secrets."postiz-db-password".path})
      YT_CLIENT=$(cat ${config.sops.secrets."postiz-yt-id".path})
      YT_SECRET=$(cat ${config.sops.secrets."postiz-yt-secret".path})
      FACE_CLIENT=$(cat ${config.sops.secrets."postiz-face-id".path})
      FACE_SECRET=$(cat ${config.sops.secrets."postiz-face-secret".path})
      TIKTOK_CLIENT=$(cat ${config.sops.secrets."postiz-tiktok-id".path})
      TIKTOK_SECRET=$(cat ${config.sops.secrets."postiz-tiktok-secret".path})
      LINKEDIN_CLIENT=$(cat ${config.sops.secrets."postiz-linkedin-id".path})
      LINKEDIN_SECRET=$(cat ${
        config.sops.secrets."postiz-linkedin-secret".path
      })


      echo DATABASE_URL="postgresql://$USER:$PASSWORD@postiz-postgres:5432/$DB" > /run/postiz.env
      echo POSTGRES_DB="$DB" >> /run/postiz.env
      echo POSTGRES_USER="$USER" >> /run/postiz.env
      echo POSTGRES_PASSWORD="$PASSWORD" >> /run/postiz.env
      echo JWT_SECRET="$JWT" >> /run/postiz.env
      echo YOUTUBE_CLIENT_ID="$YT_CLIENT" >> /run/postiz.env
      echo YOUTUBE_CLIENT_SECRET="$YT_SECRET" >> /run/postiz.env
      echo FACEBOOK_APP_ID="$FACE_CLIENT" >> /run/postiz.env
      echo FACEBOOK_APP_SECRET="$FACE_SECRET" >> /run/postiz.env
      echo TIKTOK_CLIENT_ID="$TIKTOK_CLIENT" >> /run/postiz.env
      echo TIKTOK_CLIENT_SECRET="$TIKTOK_SECRET" >> /run/postiz.env
      echo LINKEDIN_CLIENT_ID="$LINKEDIN_CLIENT" >> /run/postiz.env
      echo LINKEDIN_CLIENT_SECRET="$LINKEDIN_SECRET" >> /run/postiz.env

      chmod 0440 /run/postiz.env
      chown root:root /run/postiz.env
    '';
    serviceConfig = { Type = "oneshot"; };
  };
}
