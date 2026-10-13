{ config, domain, ... }:
let
  localDomain = "127.0.0.1";
in
{
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      virtualHosts = {
        "${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:80";
          };
        };
        "nextcloud" = {
          listen = [
            {
              addr = "${localDomain}";
              port = 9101;
            }
          ];
        };
        "nextcloud.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9101";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
            '';
          };
        };
        "immich.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9102";
          };
        };

        "radicale.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9103";
          };
        };

        "navidrome.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9104";
          };
        };

        "audiobookshelf.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9105";
          };
        };

        "flatnotes.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9106";
          };
        };

        "convertx.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9107";
          };
        };

        "metube.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9108";
          };
        };

        "karakeep.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9109";
          };
        };

        "vaultwarden.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9110";
          };
        };

        "vscode.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9111";
          };
        };

        "vikunja.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9112";
          };
        };

        "excalidraw.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9113";
          };
        };

        "gitea.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9114";
          };
        };

        "onlyoffice.${domain}" = {
          locations."/" = {
            proxyPass = "http://${localDomain}:9115";
          };
        };
      };
    };

  };
  security.acme = {
    acceptTerms = true;
    defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    defaults.email = "guifuentes8@gmail.com";
  };
}
