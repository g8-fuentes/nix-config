{ inputs, outputs, lib, config, pkgs, ... }:
let modifier = config.wayland.windowManager.sway.config.modifier;
in {

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;
    config = {
      keybindings = lib.mkOptionDefault {
        "${modifier}+Escape" = "exit";
        "${modifier}+Return" = "exec foot";
        "${modifier}+q" = "kill";

        "${modifier}+s" = "layout toggle split";
        "${modifier}+space" = "floating toggle";
        "${modifier}+f" = "fullscreen";
        "${modifier}+p" = "pseudo";
        "${modifier}+v" = "splitv";
        "${modifier}+h" = "splith";

        "${modifier}+f1" =
          "exec rofi -modes 'file-browser-extended' -show file-browser-extended";
        "${modifier}+f2" = "exec rofi-pulse-select source";
        "${modifier}+f3" = "exec rofi-pulse-select sink";
        "${modifier}+f4" = "exec rofi -modi emoji -show emoji";
        "${modifier}+f5" =
          "exec rofi -show calc -modi calc -no-show-match -no-sort -kb-accept-entry 'Control+c' -calc-command ' echo - n '{ result }' | wl-copy -sel copy'";
        "${modifier}+f6" = "exec rofi-rbw";
        "${modifier}+f7" = "exec rofi-bluetooth";
        "${modifier}+f8" = "exec rofi -show p -modi p:rofi-power-menu -lines 6";

        "XF86MonBrightnessUp" = "exec xbacklight -inc 10";
        "XF86MonBrightnessDown" = "exec xbacklight -dec 10";

        "XF86AudioRaiseVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" =
          "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";

        "Print" = ''exec grim -g "$(slurp)" - | wl-copy'';
        "Alt+Print" = ''
          exec slurp | grim - g - - | wl-copy && wl-paste > ${config.home.homeDirectory}/Pictures/$(date + "%Y-%m-%d-%H%M%S_grim.png")'';
        "Ctrl+Print" = ''
          exec wf-recorder - -audio = alsa_output.pci-0000_00_1f .3.analog-stereo .4.monitor - c vp8_vaapi - d /dev/dri/renderD128 - f ~/Videos/record_$(date + "%Y-%m-%d_%H:%M:%S.webm")'';
        "Ctrl+shift+Print" = ''
          exec wf-recorder - -audio = alsa_output.pci-0000_00_1f .3.analog-stereo .4.monitor - g "$(slurp)" - c vp8_vaapi - d /dev/dri/renderD128 - f ~/Videos/record_$(date + "%Y-%m-%d_%H:%M:%S.webm")'';
        "Shift+Print" = "exec pkill wf-recorder";
      };

      modifier = "Mod4";
      bars = [ ];
      colors = {
        background = "#1a1b26";
        focused = {
          border = "#2ac3de";
          background = "#1a1b26";
          text = "#ffffff";
          indicator = "#2ac3de";
          childBorder = "#2ac3de";
        };
        focusedInactive = {
          border = "#565f89";
          background = "#1a1b26";
          text = "#ffffff";
          indicator = "#565f89";
          childBorder = "#565f89";

        };
        placeholder = {
          border = "#565f89";
          background = "#1a1b26";
          text = "#565f89";
          indicator = "#565f89";
          childBorder = "#565f89";

        };
        unfocused = {
          border = "#565f89";
          background = "#1a1b26";
          text = "#565f89";
          indicator = "#565f89";
          childBorder = "#565f89";

        };
        urgent = {
          border = "#f7768e";
          background = "#1a1b26";
          text = "#f7768e";
          indicator = "#f7768e";
          childBorder = "#f7768e";

        };
      };
      defaultWorkspace = null;

      floating = {
        border = 3;
        criteria = [ ];
        modifier = "Mod4";
        titlebar = false;
      };

      focus = {
        followMouse = true;
        wrapping = "no";
        mouseWarping = false;
        newWindow = "smart";
      };

      fonts = {
        names = [ "JetBrainsMonoNL Nerd Font" ];
        style = "Regular";
        size = 13.0;
      };

      gaps = {
        bottom = 2;
        top = 2;
        left = 4;
        right = 4;
        horizontal = 2;
        vertical = 2;
        inner = 12;
        outer = 4;
        smartBorders = "off";
        smartGaps = false;
      };

      input = { "*" = { xkb_variant = "us"; }; };

      menu = "rofi -modes 'drun' -show-icons -show drun";

      output = {
        DP-1 = {
          bg = "~/.config/wallpapers/images/5120x1440/w1-5120.png fill";
        };
      };

      seat = { "*" = { hide_cursor = "when-typing enable"; }; };

      startup = [
        { command = "dbus-sway-environment"; }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        { command = "mako"; }
      ];

      terminal = "foot";

      window = {
        border = 3;
        commands = [ ];
        hideEdgeBorders = "none";
        titlebar = false;
      };

      workspaceAutoBackAndForth = true;
      workspaceLayout = "default";

    };

    extraConfig = "";
    extraConfigEarly = "";
    extraOptions = [ ];
    extraSessionCommands = "";

    systemd = { enable = true; };

    wrapperFeatures = { gtk = true; };

    xwayland = false;
  };

}
