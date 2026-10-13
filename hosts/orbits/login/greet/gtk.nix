{ pkgs, ... }:
let
  swayConfig = pkgs.writeText "greetd-sway-config" ''
    systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME

    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in {
  services.greetd.settings = {

    default_session = {
      command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
      user = "guifuentes8";
    };

    initial_session = {
      command = "${pkgs.sway}/bin/sway";
      user = "guifuentes8";
    };
  };

}
