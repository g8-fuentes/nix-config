{ ... }: {
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      Port = 9104;
      MusicFolder = "/var/lib/storage/navidrome/music";
    };
  };
}
