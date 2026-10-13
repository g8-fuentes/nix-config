{ config, pkgs, lib, ... }:

{
  imports = [

    ../astronauts/g8.nix

    ../orbits/services/dev
  ];
  networking.hostName = "jupiter";

  wsl = {
    enable = true;
    wslConf.network.hostname = config.networking.hostName;
    useWindowsDriver = true;

    defaultUser = "g8-fuentes";
    startMenuLaunchers = true;

    docker-desktop.enable = true;
  };

  networking.wireless.enable = lib.mkDefault false;
  systemd.services.wpa_supplicant.enable = false;

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld.enable = true;
}
