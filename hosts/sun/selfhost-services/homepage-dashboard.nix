{ ... }:
let domain = "g8-space.com.br";

in {
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 9000;
    allowedHosts = "*";
    services = [
      {
        "Files and Data Management" = [
          {
            "Immich" = {
              icon =
                "https://play-lh.googleusercontent.com/nJsRIdtaot1-FKH3kiRem4kjqUU1-_0hd_64qZH0BgtzUecYfWLCDfpk2nNVul8hOrw=w240-h480-rw";
              description = "Photos service";
              href = "https://immich.${domain}";
              siteMonitor = "https://immich.${domain}";
            };
          }
          {
            "Radicale" = {
              icon =
                "https://www.cloudron.io/store/icons/org.radicale.cloudronapp2.png";
              description = "CalDav service";
              href = "https://radicale.${domain}";
              siteMonitor = "https://radicale.${domain}";
            };
          }

          {
            "Nextcloud" = {
              icon =
                "https://getumbrel.github.io/umbrel-apps-gallery/nextcloud/icon.svg";
              description = "Files service";
              href = "https://nextcloud.${domain}";
              siteMonitor = "https://nextcloud.${domain}";
            };
          }

        ];
      }
      {
        "Media, Audio and RSS feeds" = [
          {
            "AudioBook Shelf" = {
              icon =
                "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Audiobookshelf_Logo.svg/2048px-Audiobookshelf_Logo.svg.png";
              description = "Audiobook + Podcast service";
              href = "https://audiobookshelf.${domain}";
              siteMonitor = "https://audiobookshelf.${domain}";
            };
          }
          {
            "Karakeep" = {
              icon =
                "https://play-lh.googleusercontent.com/95d3e2a2-m4WVn7RYmdlOpdXJditxSpj4iVCF70aWPxJUQEP1HOdbiUg6L2GDOHfFV8";
              description = "Bookmarks + feed RSS service";
              href = "https://karakeep.${domain}";
              siteMonitor = "https://karakeep.${domain}";
            };
          }

          {
            "Navidrome" = {
              icon = "https://avatars.githubusercontent.com/u/26692192?v=4";
              description = "Music service";
              href = "https://navidrome.${domain}";
              siteMonitor = "https://navidrome.${domain}";
            };
          }

        ];
      }

      {
        "Notes, Drawing and Tasks" = [
          {
            "Excalidraw" = {
              icon = "https://docs.excalidraw.com/img/logo.svg";
              description = "Draw service";
              href = "https://excalidraw.${domain}";
              siteMonitor = "https://excalidraw.${domain}";
            };
          }

          {
            "Flat Notes" = {
              icon =
                "https://raw.githubusercontent.com/runtipi/runtipi-appstore/master/apps/flatnotes/metadata/logo.jpg";
              description = "Note-taking service";
              href = "https://flatnotes.${domain}";
              siteMonitor = "https://flatnotes.${domain}";
            };
          }

          {
            "Vikunja" = {
              icon =
                "https://community.vikunja.io/uploads/default/original/1X/894bd400d7c5bde78a65ba02e326798ccfb82006.png";
              description = "Board and Tasks service";
              href = "https://vikunja.${domain}";
              siteMonitor = "https://vikunja.${domain}";
            };
          }

        ];
      }

      {
        "Other Tools and Services" = [
          {
            "ConvertX" = {
              icon =
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhheyR18DT4a_JSZ7gBsrBxX9CC7U0lJ2Vug&s";
              description = "Convert images service";
              href = "https://convertx.${domain}";
              siteMonitor = "https://convertx.${domain}";
            };
          }
          {
            "MeTube" = {
              icon = "https://files.raycast.com/6w0l0p8m3uytgj1zc4bkssgalk05";
              description = "Youtube downloader service";
              href = "https://metube.${domain}";
              siteMonitor = "https://metube.${domain}";
            };
          }
          {
            "Vaultwarden" = {
              icon =
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQise_TS6EZCtz4EmSyIMEH5ZPAuQLrVEZgmQ&s";
              description = "Secrets service";
              href = "https://vaultwarden.${domain}";
              siteMonitor = "https://vaultwarden.${domain}";
            };
          }

        ];
      }
      {
        "Development Tools and Services" = [
          {
            "Gitea" = {
              icon =
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Gitea_Logo.svg/800px-Gitea_Logo.svg.png";
              description = "Git service";
              href = "https://gitea.${domain}";
              siteMonitor = "https://gitea.${domain}";
            };
          }
          {
            "Vscode" = {
              icon =
                "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Visual_Studio_Code_1.35_icon.svg/2048px-Visual_Studio_Code_1.35_icon.svg.png";
              description = "Code editor service";
              href = "https://vscode.${domain}";
              siteMonitor = "https://vscode.${domain}";
            };
          }
        ];
      }

    ];

    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/var/lib/storage";
          memory = true;
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];

    settings = {
      title = "[G8] Space";
      description = "G8 Space dashboard";
      background.blur = "md";
      background.image =
        "https://images8.alphacoders.com/545/thumb-1920-545583.jpg";
      cardBlur = "xl";
      favicon = "https://cdn-icons-png.flaticon.com/512/2687/2687003.png";
      statusStyle = "dot";
      theme = "dark";
      headerStyle = "underlined";
      disableCollapse = true;
      layout = [
        {
          "Development Tools and Services" = {
            style = "column";
            columns = 1;
          };
        }
        {
          "Files and Data Management" = {
            style = "column";
            columns = 1;
          };
        }
        {
          "Media, Audio and RSS feeds" = {
            style = "column";
            columns = 1;
          };
        }
        {
          "Notes, Drawing and Tasks" = {
            style = "column";
            columns = 1;
          };
        }
        {
          "Other Tools and Services" = {
            style = "row";
            columns = 4;
          };
        }

      ];
    };
  };
}
