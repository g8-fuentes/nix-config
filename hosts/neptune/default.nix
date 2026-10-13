{ pkgs, ... }:
{
  imports = [

    ./hardware-configuration.nix
    ../orbits/hardware/bluetooth.nix
    ../orbits/hardware/logitech.nix

    ../orbits/hardware/gpu/amd.nix

    ../core

    ../orbits/boot/grub.nix

    ../orbits/login/sddm.nix

    ../orbits/interfaces/DE/kde.nix

    ../orbits/services/backlight.nix

    ../orbits/services/temperature.nix
    ../orbits/services/dev

    ../astronauts/g8.nix
    ../orbits/stylix.nix

  ];

  console.keyMap = "us";
  services.xserver.xkb.layout = "us";

  networking.hostName = "neptune";

}
