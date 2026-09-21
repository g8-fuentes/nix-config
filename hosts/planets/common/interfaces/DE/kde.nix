{ pkgs, ... }:

{
  imports = [ ];

  services = {
    xserver.enable = true;
    desktopManager.plasma6 = {
      enable = true;
    };
    displayManager.defaultSession = "plasma";
  };

  # Ativa o X11 windowing system

  # Ativa o Display Manager (SDDM é o padrão do KDE)

  # Ativa o ambiente de desktop KDE Plasma (Plasma 6)

  programs.dconf.enable = true;
  programs.partition-manager.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # default Kde Programs

  environment.systemPackages = (
    with pkgs.kdePackages;
    [
      kmail
      kdenlive
      kate
      ktorrent
      kmag
      akregator
      #knotes
      kasts
      kaccounts-integration
      kaccounts-providers
      kio-gdrive
      dragon
      qtstyleplugin-kvantum
    ]
  );
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [ plasma-browser-integration ];
}
