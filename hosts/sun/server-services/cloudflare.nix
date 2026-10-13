{
  config,
  pkgs,
  domain,
  ...
}:
let
  localDomain = "127.0.0.1";
in
{
  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "0c006025-b0ae-414d-bb54-542079b3dac2" = {
          credentialsFile = "${config.users.users.g8-fuentes.home}/.cloudflared/0c006025-b0ae-414d-bb54-542079b3dac2.json";

          ingress = {
            "${domain}" = {
              service = "http://${localDomain}:9000";
            };
            "nextcloud.${domain}" = {
              service = "http://${localDomain}:9101";
            };
            "immich.${domain}" = {
              service = "http://${localDomain}:9102";
            };
            "radicale.${domain}" = {
              service = "http://${localDomain}:9103";
            };
            "navidrome.${domain}" = {
              service = "http://${localDomain}:9104";
            };
            "audiobookshelf.${domain}" = {
              service = "http://${localDomain}:9105";
            };
            "flatnotes.${domain}" = {
              service = "http://${localDomain}:9106";
            };
            "convertx.${domain}" = {
              service = "http://${localDomain}:9107";
            };
            "metube.${domain}" = {
              service = "http://${localDomain}:9108";
            };
            "karakeep.${domain}" = {
              service = "http://${localDomain}:9109";
            };
            "vaultwarden.${domain}".service = "http://${localDomain}:9110";
            "vscode.${domain}" = {
              service = "http://${localDomain}:9111";
            };
            "vikunja.${domain}" = {
              service = "http://${localDomain}:9112";
            };
            "excalidraw.${domain}" = {
              service = "http://${localDomain}:9113";
            };
            "gitea.${domain}" = {
              service = "http://${localDomain}:9114";
            };
            "onlyoffice.${domain}" = {
              service = "http://${localDomain}:9115";
            };
          };

          default = "http_status:404";
        };
      };

    };
  };

  environment.systemPackages = [ pkgs.cloudflared ];

}
