{
  lib,
  pkgs,
  config,
  ...
}:
let
  cw = ./scripts/cw.sh;
  term = "kitty";
  startupScript = pkgs.writeShellScriptBin "start" ''
    wl-clipboard-history -t &
    systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME
  '';
in
{
  imports = [
    ../../browsers/qutebrowser.nix
    ./common/wayland.nix
  ];
  services.gnome-keyring.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      exec-once = "${startupScript}/bin/start";
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 3;
        "col.active_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base0D}ff)";
        "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base01}ff)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 2;
          passes = 3;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windowsOut, 1, 7, default, popin 80%"
          "windows, 1, 7, myBezier"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = { };
      misc = { };
      input = {
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };
      cursor = {
        no_hardware_cursors = true;
        enable_hyprcursor = false;
        hide_on_touch = true;
      };

    };

    extraConfig = ''
        $mainMod = SUPER
        $term = ${term}

        bind = $mainMod, Return, exec, $term
        bind = $mainMod, Escape, exit,
        bind = $mainMod, Space, exec, rofi -modes "drun" -show-icons -show drun
        bind = $mainMod, Q, killactive,
        bind = $mainMod, S, togglesplit, # dwindle
        bind = $mainMod, F, togglefloating,
        bind = $mainMod, M, fullscreen, 0

        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d

        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        bind=CTRL_SHIFT,R,submap,resize
        submap=resize

        binde=,right,resizeactive,10 0
        binde=,left,resizeactive,-10 0
        binde=,up,resizeactive,0 -10
        binde=,down,resizeactive,0 10

        bind=,escape,submap,reset 

        submap=reset

        bind = ,XF86MonBrightnessUp, exec, xbacklight -inc 10
        bind = ,XF86MonBrightnessDown, exec, xbacklight -dec 10
                
        bind = ,XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
        bind = ,XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
        bind = ,XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
        bind = ,XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
                
        bind = ,XF86AudioPrev, exec, playerctl previous
        bind = ,XF86AudioPlay, exec, playerctl play-pause
        bind = ,XF86AudioNext, exec, playerctl next


        bind = ,Print, exec, grim -g "$(slurp)" - | wl-copy 
        bind = SUPER SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy 

        bind = $mainMod, F1, exec, 
        bind = $mainMod, F2, exec, 
        bind = $mainMod, F3, exec, 
        bind = $mainMod, F4, exec, 
        bind = $mainMod, F5, exec,
        bind = $mainMod, F6, exec, 
        bind = $mainMod, F7, exec, 
        bind = $mainMod, F8, exec, grim -g "$(slurp)" - | wl-copy 
        bind = $mainMod, F9, exec, 
        bind = $mainMod, F10, exec, rofi-bluetooth 
        bind = $mainMod, F11, exec, rofi-rbw  --clipboarder wl-copy --keybindings 'Ctrl+1:copy:username,Ctrl+2:copy:password,Ctrl+3:copy:totp,Ctrl+4:copy:notes,Ctrl+5:sync'
        bind = $mainMod, F12, exec, rofi -show p -modi p:rofi-power-menu -lines 6

        bind = $mainMod SHIFT, p, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a
        bind = $mainMod SHIFT, b, exec, qutebrowser;
        bind = $mainMod SHIFT, m, exec, ${term} -e spotify_player;
        bind = $mainMod SHIFT, e, exec, ${term} -e nvim;
        bind = $mainMod SHIFT, f, exec, ${term} -e yazi;
        bind = $mainMod, W, exec, bash ${cw} change


        bind = ALT,Space, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next
        bind = ALT,Space, exec, hyprctl switchxkblayout logitech-usb-receiver nextp

    '';
  };
}
