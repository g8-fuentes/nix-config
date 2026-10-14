{
  pkgs,
  options,
  outputs,
  ...
}:
{
  programs.nixvim = outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>f" = {
          action = "find_files";
          options = {
            desc = "Telescope Find Files";
          };
          mode = [ "n" ];
        };
        "<leader>s" = {
          action = "live_grep";
          options = {
            desc = "Telescope Search Word";
          };
          mode = [ "n" ];
        };

      };
      settings = {
        defaults = {
          mappings = {
            n = {
              "q".__raw = "require('telescope.actions').close";
            };
          };
        };
        pickers = {
          find_files = {
            theme = "dropdown";
          };
          live_grep = {
            theme = "dropdown";
          };

        };
      };
    };
  };
}
