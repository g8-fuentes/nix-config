{
  pkgs,
  lib,
  options,
  outputs,
  ...
}:
let
  nixvimOptions = options.programs.nixvim.type.getSubOptions [ ];
in
{
  programs.nixvim = outputs.lib.existing nixvimOptions {
    keymaps = lib.optionals (nixvimOptions.plugins ? yazi) [
      {
        action.__raw = ''function () require("yazi").yazi() end'';
        key = "<C-b>";
        options = {
          silent = true;
        };
      }
    ];
    plugins.yazi = {
      enable = true;
      settings = {
        enable_mouse_support = true;
        floating_window_scaling_factor = 0.8;
        log_level = "off";
        open_for_directories = false;
        yazi_floating_window_border = "rounded";
        yazi_floating_window_winblend = 0;
        keymaps = {
          copy_relative_path_to_selected_files = "<c-y>";
          cycle_open_buffers = "<tab>";
          grep_in_directory = "<c-s>";
          open_file_in_horizontal_split = "<c-x>";
          open_file_in_tab = "<c-t>";
          open_file_in_vertical_split = "<c-v>";
          replace_in_directory = "<c-g>";
          send_to_quickfix_list = "<c-q>";
          show_help = "<f1>";
        };
      };
    };
  };
}
