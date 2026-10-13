{ pkgs, config, ... }:
let
  alert = pkgs.writeShellScript "alert.sh" ''
    ${pkgs.pipewire}/bin/pw-play --volume=0,04  
  '';
in {
  services.dunst = {
    enable = true;
    package = pkgs.dunst;

    settings = {
      global = {
        width = 400;
        height = 200;
        min_icon_size = 64;
        max_icon_size = 64;
        corner_radius = 8;
        gaps = true;
        gap_size = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        offset = "10x10";
        origin = "bot-right";
        frame_width = 2;
        frame_color = "#${config.lib.stylix.colors.base01}";
        notification_limit = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        sort = "yes";
      };

      play_sound = {
        summary = "*";
        script = "${alert}";
      };
    };
  };

  home.packages = with pkgs; [ libnotify ];
}

