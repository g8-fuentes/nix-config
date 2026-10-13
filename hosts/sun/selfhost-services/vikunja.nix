{ ... }: {
  services.vikunja = {
    enable = true;
    port = 9112;
    frontendScheme = "http";
    frontendHostname = "vikunja.g8-space.com.br";
    settings = { service.enableregistration = false; };
  };
}
