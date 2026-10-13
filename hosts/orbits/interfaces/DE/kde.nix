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

  programs.dconf.enable = true;
  programs.partition-manager.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = (
    with pkgs.kdePackages;
    [
      kmail
      kdenlive
      kate
      ktorrent
      kmag
      akregator
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
