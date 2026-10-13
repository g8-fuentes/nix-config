{ pkgs, ... }: {
  services.immich = {
    enable = true;
    host = "127.0.0.1";
    port = 9102;
    openFirewall = true;
    mediaLocation = "/var/lib/storage/immich";

  };

  users.users.immich.extraGroups = [ "video" "render" ];
  environment.systemPackages = [ pkgs.immich-cli ];
}

