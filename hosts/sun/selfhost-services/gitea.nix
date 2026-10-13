{ domain, ... }: {
  services.gitea = {
    enable = true;

    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "gitea.${domain}";
        ROOT_URL = "https://gitea.${domain}";
        HTTP_PORT = 9114;
      };
      service.DISABLE_REGISTRATION = true;
    };
  };
}

