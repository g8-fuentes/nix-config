{ ... }: {
  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
    port = 9105;
    dataDir =
      "storage/audiobookshelf";
  };
}
