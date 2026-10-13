{ ... }: {
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vaultwarden.g8-space.com.br";
      SIGNUPS_ALLOWED = true;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 9110;

      ROCKET_LOG = "critical";

      SMTP_HOST = "127.0.0.1";
      SMTP_PORT = 25;
      SMTP_SSL = false;

      SMTP_FROM = "admin@bitwarden.example.com";
      SMTP_FROM_NAME = "example.com Bitwarden server";
    };
  };
}
