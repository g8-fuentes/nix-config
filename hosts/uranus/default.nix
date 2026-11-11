{ theme, ... }:
{
  imports = [

    ./hardware-configuration.nix
    ../orbits/hardware/bluetooth.nix
    ../orbits/hardware/logitech.nix

    ../orbits/hardware/gpu/amd.nix

    ../core

    ../orbits/boot/grub.nix

    ../orbits/login/greet

    ../orbits/interfaces/WM/hyprland.nix

    ../orbits/services/backlight.nix

    ../orbits/services/temperature.nix
    ../orbits/services/dev

    ../astronauts/g8.nix
    ../orbits/stylix.nix

  ];

  console.keyMap = "br-abnt2";
  services.xserver.xkb.layout = "br";
  services.xserver.xkb.variant = "abnt2";

  stylix.image = theme.wallpaper "uranus";
  networking.hostName = "uranus";

  # Root fs is a slow 5400rpm HDD; nh-clean's weekly GC has Persistent=true
  # and was running at full I/O priority right after boot (~15min), starving
  # disk access for every app the user tried to open.
  systemd.services.nh-clean.serviceConfig = {
    IOSchedulingClass = "idle";
    CPUSchedulingPolicy = "idle";
    Nice = 19;
  };
  systemd.timers.nh-clean.timerConfig.RandomizedDelaySec = "30min";

}
