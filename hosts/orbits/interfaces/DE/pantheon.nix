{ pkgs, ... }: {
  services.xserver.desktopManager.pantheon.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.systemPackages = with pkgs; [ pantheon.appcenter ];
}
