{ theme, ... }:
{
  imports = [

    ./hardware-configuration.nix
    ../orbits/hardware/bluetooth.nix
    ../orbits/hardware/logitech.nix

    ../orbits/hardware/gpu/nvidia-prime.nix

    ../core

    ../orbits/boot/grub.nix

    ../orbits/login/gdm.nix

    ../orbits/interfaces/DE/gnome.nix

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

}
