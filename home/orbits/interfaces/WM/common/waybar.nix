{ pkgs, config, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
    settings = [
      {
        fixed-center = true;
        name = "top";
        layer = "top";
        position = "top";
        exclusive = true;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [
          "disk"
          "cpu"
          "memory"
          "temperature"
          "sway/language"
          "keyboard-state"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "tray"
          "clock"
        ];
        "hyprland/workspaces" = {
          "all-outputs" = true;
          "active-only" = false;
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "on-click" = "activate";
          "format" = "{icon}";
          "format-icons" = {
            "1" = "<span font='16' rise='1000'>󰯬</span>";
            "2" = "<span font='16' rise='1000'>󰯯</span>";
            "3" = "<span font='16' rise='1000'>󰯲</span>";
            "4" = "<span font='16' rise='1000'>󰯵</span>";
            "5" = "<span font='16' rise='1000'>󰯸</span>";
            "6" = "<span font='16' rise='1000'>󰯻</span>";
            "7" = "<span font='16' rise='1000'>󰯾</span>";
            "8" = "<span font='16' rise='1000'>󰰁</span>";
            "9" = "<span font='16' rise='1000'>󰰄</span>";
            "urgent" = "";
            "default" = "";
          };
          "persistent-workspaces" = {
            "*" = 9;
          };
        };
        "sway/language" = {
          "format" = "{short} {variant}";
        };
        "keyboard-state" = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{icon}{name}";
          "format-icons" = {
            "locked" = " ";
            "unlocked" = " ";
          };
        };
        "tray" = {
          "icon-size" = 16;
          "spacing" = 10;
        };
        "sway/mode" = {
          "format" = ''<span style="italic">{}</span>'';
        };
        "sway/scratchpad" = {
          "format" = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = [
            ""
            ""
          ];
          "tooltip" = true;
          "tooltip-format" = "{app}= {title}";
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "clock" = {
          "timezone" = "America/Sao_Paulo";
          "format" = "{:%H:%M:%S}";
          interval = 1;
          tooltip = true;
          "tooltip-format" = "{:%d/%m/%Y}";
          "format-alt" = "{%d-%m-%y}";
        };
        "disk" = {
          "interval" = 30;
          "format" = " {percentage_used}%";
          "path" = "/";
        };
        "cpu" = {
          interval = 2;
          "format" = " {usage}%";
          "tooltip" = true;
        };
        "memory" = {
          "format" = "󰟁 {}%";
        };
        "temperature" = {
          "thermal-zone" = 2;
          "critical-threshold" = 80;
          "format-critical" = "{icon} {temperatureC}°C";
          "format" = "{icon} {temperatureC}°C";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "backlight" = {
          "device" = "acpi_video1";
          "format" = "{icon} {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "battery" = {
          "states" = {
            "good" = 100;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{time} {icon}";
          "format-good" = "{icon} {capacity}%";
          "format-full" = "{icon} {capacity}%";
          "format-icons" = [
            " "
            " "
            " "
            " "
            " "
          ];
        };
        "battery#bat2" = {
          "bat" = "BAT2";
        };
        "network" = {
          "format-wifi" = "  {essid}";
          "format-ethernet" = "󱂇 Connected";
          "tooltip-format" = "{ifname} via {gwaddr}";
          "format-linked" = "{ifname} (No IP)";
          "format-disconnected" = "󰅛 Disconnected";
          "format-alt" = "{Signal} - {signalStrength}%";
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "󰋋 {volume}%";
          "format-bluetooth-muted" = "󰟎 {volume}%";
          "format-muted" = "󰖁 {volume}%";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "󰋋";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              " "
              " "
            ];
          };
          "on-click" = "pavucontrol";
        };
        "cava" = {
          "framerate" = 120;
          "autosens" = 0;
          "sensitivity" = 10;
          "bars" = 16;
          "lower_cutoff_freq" = 50;
          "higher_cutoff_freq" = 10000;
          "method" = "pulse";
          "source" = "auto";
          "stereo" = true;
          "reverse" = false;
          "bar_delimiter" = 0;
          "monstercat" = true;
          "waves" = false;
          "noise_reduction" = 0.3;
          "input_delay" = 2;
          "format-icons" = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          "actions" = {
            "on-click-right" = "mode";
          };
        };
        "mpris" = {
          "format" = "{player_icon}[{position}|{length}] {artist}|{title}";
          "format-paused" = "{status_icon}{artist}|{title}";
          max-length = 60;
          interval = 1;
          "player-icons" = {
            "default" = "󰋋 ";
            "mpv" = "󰋋 ";
            "spotify_player" = " ";
          };
          "status-icons" = {
            "paused" = "⏸ ";
          };
          "ignored-players" = [ ];
        };
        "mpd" = {
          "format" =
            "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
          "format-disconnected" = "Disconnected ";
          "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          "unknown-tag" = "N/A";
          "interval" = 2;
          "consume-icons" = {
            "on" = " ";
          };
          "random-icons" = {
            "off" = ''<span color="#f53c3c"></span> '';
            "on" = " ";
          };
          "repeat-icons" = {
            "on" = " ";
          };
          "single-icons" = {
            "on" = "1 ";
          };
          "state-icons" = {
            "paused" = "";
            "playing" = "";
          };
          "tooltip-format" = "MPD (connected)";
          "tooltip-format-disconnected" = "MPD (disconnected)";
        };
      }
    ];
    style = ''
      * {
          font-family: ${config.stylix.fonts.monospace.name};
          font-weight: bold;
          font-size: 12px;
      }

      window#waybar {

          background: #${config.lib.stylix.colors.base00};
          color: #${config.lib.stylix.colors.base0C};
          border-radius: 0px;
      }

      #cpu,
      #memory,
      #disk,
      #temperature,
      #keyboard-state,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #backlight {
        padding: 4px 6px;
        margin: 4px 2px;
      }

      #workspaces {
          margin: 0 4px;
      }

      #workspaces button {
        color: #${config.lib.stylix.colors.base0D};
        background-color: #${config.lib.stylix.colors.base00};
        padding: 0 4px;
        margin: 0 2px;
        border-radius: 0px;

      }

      #workspaces button.active {
        color: #${config.lib.stylix.colors.base0A};
        background-color: #${config.lib.stylix.colors.base00};
        font-weight: bold;
        box-shadow: none;
        text-shadow: none;
      }

      #workspaces button.focused {
        color: #${config.lib.stylix.colors.base00};
        background-color: #${config.lib.stylix.colors.base00};
      }

      #workspaces button.urgent {
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base08};
      }

      #workspaces button:hover {
        background-color: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base05};
      }

      #disk {
        color: #${config.lib.stylix.colors.base05};
      }

      #cpu {
        color: #${config.lib.stylix.colors.base05};
      }

      #memory {
        color: #${config.lib.stylix.colors.base05};
      }

      #temperature {
        color: #${config.lib.stylix.colors.base0B};
      }

      #keyboard-state {
        color: #${config.lib.stylix.colors.base0D};
      }

      #backlight {
        color: #${config.lib.stylix.colors.base0C};
      }

      #network {
        color: #${config.lib.stylix.colors.base09};
      }

      #pulseaudio {
        color: #${config.lib.stylix.colors.base0E};
      }

      #battery {
        color: #${config.lib.stylix.colors.base0A};
      }

      #clock {
        color: #${config.lib.stylix.colors.base0C};
        margin-right: 12px;
      }

      #custom-nix-logo {
        margin-left: 12px;
      }

      #mpris {
        color: #${config.lib.stylix.colors.base0A};
        margin-left: 12px;
        margin-right: 12px;
      }

       #custom-media {
        color: #${config.lib.stylix.colors.base0A};
        margin-left: 12px;
        margin-right: 12px;
      }

      #cava {
        color: #${config.lib.stylix.colors.base0E};
        margin: 0 12px;
      }
    '';
  };
}
