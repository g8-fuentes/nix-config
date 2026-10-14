{
  pkgs,
  config,
  lib,
  options,
  outputs,
  ...
}:
{
  programs.nixvim = lib.mkIf (lib.versionAtLeast pkgs.neovim-unwrapped.version "0.10") (
    outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
      plugins.neorg = {
        enable = true;
        package = pkgs.vimPlugins.neorg;
        settings.lazyLoading = true;
        settings.load = {
          "core.defaults" = {
            __empty = null;
          };
          "core.concealer".config = {
            icon_preset = "diamond";
          };
          "core.completion" = {
            config = {
              engine = "nvim-cmp";
              name = "[Norg]";
            };
          };
          "core.dirman" = {
            config = {
              workspaces = {
                main = "${config.home.homeDirectory}/Documents/Notes/main";
                journal = "${config.home.homeDirectory}/Documents/Notes/journal";
                study = "${config.home.homeDirectory}/Documents/Notes/study";
                media = "${config.home.homeDirectory}/Documents/Notes/social";
              };
              default_workspace = "main";
            };
          };
          "core.esupports.metagen" = {
            config = {
              author = "${config.home.username}";
              type = "auto";
              update_date = true;
            };
          };
          "core.export" = {
            __empty = null;
          };
          "core.export.markdown" = {
            config = {
              extensions = "all";
            };
          };
          "core.integrations.nvim-cmp" = {
            config = {
              sources = {
                name = "neorg";
              };
            };
          };
          "core.highlights" = {
            __empty = null;
          };
          "core.integrations.treesitter" = {
            config = {
              configure_parsers = true;
              install_parsers = true;
            };
          };
          "core.journal" = {
            config = {
              strategy = "flat";
              workspace = "journal";
            };
          };
          "core.keybinds" = {
            config = {
              default_keybinds = true;
              neorg_leader = ",";
            };
          };
          "core.looking-glass" = {
            __empty = null;
          };
          "core.presenter" = {
            config = {
              zen_mode = "zen-mode";
            };
          };
          "core.qol.toc" = {
            __empty = null;
          };
          "core.qol.todo_items" = {
            __empty = null;
          };
          "core.summary" = {
            config = {
              strategy = "by_path";
            };
          };
          "core.tangle" = {
            config = {
              report_on_empty = false;
            };
          };
          "core.ui" = {
            __empty = null;
          };
        };
      };
    }
  );
}
