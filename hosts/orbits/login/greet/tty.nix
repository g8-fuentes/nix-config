{ pkgs, config, ... }:
{
  services.greetd.settings.default_session = {
    command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd start-hyprland -t --asterisks -r --remember-user-session --user-menu -g 'Welcome, Guilherme!' --power-shutdown 'shutdown -h now' --power-reboot 'shutdown -r now'";
    user = "g8";
  };

}
