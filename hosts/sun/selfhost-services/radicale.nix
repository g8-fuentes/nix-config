{ ... }: {
  services.radicale = {
    enable = true;
    settings = {
      server.hosts = [ "127.0.0.1:9103" ];
      auth = {
        type = "htpasswd";
      };
    };
  };
}
