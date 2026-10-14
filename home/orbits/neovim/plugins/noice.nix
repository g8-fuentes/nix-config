{ options, outputs, ... }: {
  programs.nixvim = outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
    plugins = {
      nui.enable = true;
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000";
        };
      };
      noice = {
        enable = true;
        settings = {
          cmdline = {
            format = {
              cmdline = {
                icon = " ";
                lang = "vim";
                pattern = "^:";
              };
              filter = {
                icon = "$";
                lang = "bash";
                pattern = "^:%s*!";
              };
              help = {
                icon = "󰘥 ";
                pattern = "^:%s*he?l?p?%s+";
              };
              input = { };
              lua = {
                icon = "";
                lang = "lua";
                pattern = "^:%s*lua%s+";
              };
              search_down = {
                icon = " ";
                kind = "search";
                lang = "regex";
                pattern = "^/";
              };
              search_up = {
                icon = " ";
                kind = "search";
                lang = "regex";
                pattern = "^%?";
              };
            };
          };
          lsp = {
            progress = {
              enabled = true;
            };
            override = {
              "cmp.entry.get_documentation" = true;
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
            };
          };
          messages.enabled = true;
          health.checker = false;
          presets = {
            bottom_search = false;
            command_palette = true;
            long_message_to_split = true;
            inc_rename = true;
            lsp_doc_border = true;
          };
          popupmenu = {
            enabled = true;
            backend = "nui";
          };
          views = {
            cmdline_popup = {
              position = {
                row = "50%";
                col = "50%";
              };
              size = {
                width = 60;
                height = "auto";
              };
            };
            popupmenu = {
              relative = "editor";
              position = {
                row = 50;
                col = "50%";
              };
              size = {
                width = 60;
                height = 10;
              };
              border = {
                style = "rounded";
                padding = [
                  0
                  1
                ];
              };
              win_options = {
                winhighlight = {
                  Normal = "Normal";
                  FloatBorder = "DiagnosticInfo";
                };
              };
            };
          };
        };
      };
    };
  };
}
