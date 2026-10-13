{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    ../orbits/boot/systemd-boot.nix
    ../astronauts/g8.nix

    ./selfhost-services/homepage-dashboard.nix

    ./selfhost-services/audiobookshelf.nix
    ./selfhost-services/vaultwarden.nix
    ./server-services/nginx.nix
    ./server-services/cloudflare.nix
    ./server-services/networking.nix
    ./server-services/postgres.nix
    ./server-services/tailscale.nix
  ];
  services.getty.autologinUser = "g8-fuentes";
  services.openssh.enable = true;

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = false;
      open = false;
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  console.keyMap = "br-abnt2";
  services.xserver.xkb.layout = "br";
  services.xserver.xkb.variant = "abnt2";

}
