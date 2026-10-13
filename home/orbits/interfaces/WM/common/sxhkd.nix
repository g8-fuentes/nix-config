{ pkgs, outputs, config, ... }:
let
  BLANK = "#${config.colorScheme.palette.base00}00";
  BACKGROUND = "#${config.colorScheme.palette.base00}AA";
  CLEAR = "#${config.colorScheme.palette.base01}22";
  DEFAULT = "#${config.colorScheme.palette.base0B}cc";
  TEXT = "#${config.colorScheme.palette.base06}ee";
  WRONG = "#${config.colorScheme.palette.base08}bb";
  INPUT = "#${config.colorScheme.palette.base0D}ee";
  VERIFYING = "#${config.colorScheme.palette.base0A}bb";
  screen-locker = pkgs.writeShellScript "script" ''
    ${pkgs.i3lock-color}/bin/i3lock  --beep --nofork --screen 1 --blur 5 --indicator --ignore-empty-password --clock --line-uses-ring --radius=300 --ring-width=18.0 --line-color=${BLANK} --inside-color=${BACKGROUND} --ring-color=${DEFAULT} --insidever-color=${CLEAR} --ringver-color=${VERIFYING} --insidewrong-color=${CLEAR} --ringwrong-color=${WRONG} --keyhl-color=${INPUT} --bshl-color=${WRONG} --separator-color=${DEFAULT} --verif-color=${TEXT} --wrong-color=${TEXT} --modif-color=${TEXT} --date-color=${TEXT} --time-color=${TEXT} --time-str="%H:%M:%S" --date-str="Hoje é %A, dia %d/%m/%Y." --verif-text="Analyzing..." --wrong-text="Password error!" --noinput-text="None!" --lock-text="Locking screen..." --lockfailed-text="Lock failed!"  --time-align=0 --date-align=0 --time-font="Dank Mono:style=Italic" --date-font="Dank Mono:style=Italic" --verif-font="Dank Mono:style=Italic" --wrong-font="Dank Mono:style=Italic" --time-size=48 --date-size=32 --verif-size=32 --wrong-size=32 --date-pos="tx:ty+50"
  '';
in {
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "kitty";
      "super + @space" = "rofi -modes 'drun' -show-icons -show drun";
      "super + Escape" = "bspc quit";
      "super + ctrl + Escape" = "${screen-locker}";
      "super + alt + r" = "bspc wm -r";
      "super + BackSpace" =
        "pkill -USR1 -x sxhkd && notify-send sxhkd reloaded!";
      "super + {_,shift + }q" = "bspc node -{c,k}";
      "super + t" = "bspc node -t tiled";
      "super + shift + t" = "bspc node -t pseudo_tiled";
      "super + f" = "bspc node -t floating";
      "super + m" = "bspc node -t fullscreen";
      "super + shift + {Left,Down,Up,Right}" =
        "bspc node -s {west,south,north,east}";
      "super + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";
      "super + {grave,Tab}" = "bspc {node,desktop} -f last";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + ctrl + {Left,Down,Up,Right}" =
        "bspc node -p {west,south,north,east}";
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
      "super + ctrl + space" = "bspc node -p cancel";
      "super + ctrl + shift + space" =
        "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
      "super + alt + {Left,Down,Up,Right}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + alt + shift + {Left,Down,Up,Right}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {h,j,k,l}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";

      "XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ +1000";
      "XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ -1000";
      "XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      "XF86AudioMicMute" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
      "XF86MonBrightnessDown" = "brightnessctl set 5%-";
      "XF86MonBrightnessUp" = "brightnessctl set 5%+";
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86AudioNext" = "playerctl next";
      "XF86AudioPrev" = "playerctl previous";

      "super + F1" = "rofi -show calc -modi calc -no-show-match -no-sort";
      "super + F2" = "rofi -modi emoji -show emoji";
      "super + F3" = "";
      "super + F4" = "";
      "super + F5" = "";
      "super + F6" = "";
      "super + F7" = "";
      "super + F8" = "rofi-systemd";
      "super + F9" = "rofi-pulse-select sink";
      "super + F10" = "rofi-bluetooth";
      "super + F11" = "rofi-rbw";
      "super + F12" = "rofi -show p -modi p:rofi-power-menu -lines 6";

      "super + shift + F1" = "xrandr -s 5120x1440";
      "super + shift + F2" = "xrandr -s 3840x1080";
      "super + shift + F3" = "xrandr -s 2560x1440";
      "super + shift + f4" = "xrandr -s 1920x1080";

      "super + shift + p" = "xcolor -s clipboard";
      "super + shift + b" = "qutebrowser";
      "super + shift + m" = "kitty -e spotify_player";
      "super + shift + e" = "kitty -e nvim";
      "super + shift + f" = "kitty -e yazi";
      "Print" = "flameshot gui";

    };

  };
}
