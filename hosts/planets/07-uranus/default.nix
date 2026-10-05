{ pkgs, ... }:
{
  imports = [

    # HARDWARE ----------------------------------------

    # Hardware config (required)
    ./hardware-configuration.nix
    ../common/hardware/bluetooth.nix
    ../common/hardware/logitech.nix

    # Hardware Gpu (if exist)
    ../common/hardware/gpu/nvidia-prime.nix

    # NIXOS CONFIG ------------------------------------

    # global NixOs Config
    ../common

    # Boot initial (grub or systemd)
    ../common/boot/grub.nix

    # Login Manager
    ../common/login/gdm.nix

    # Choice Interface (WM and/or DE)

    ../common/interfaces/DE/gnome.nix

    # Active services
    ../common/services/backlight.nix

    ../common/services/temperature.nix
    ../common/services/dev

    # User
    ../common/users/g8.nix
    ../common/stylix.nix

  ];

  # SYSTEM CONFIGS --------------------------------------

  # Set the keyboard layout for Xorg (initial setting for GNOME)
  console.keyMap = "br-abnt2";
  services.xserver.xkb.layout = "br";
  services.xserver.xkb.variant = "abnt2";

  networking.hostName = "uranus";

}
