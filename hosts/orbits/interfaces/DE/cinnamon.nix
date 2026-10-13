{ pkgs, ... }: {
  services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = true;
}
