{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
        xfce.enableScreensaver = true;
        xterm.enable = false;
      };
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "g8-fuentes";
      };
      defaultSession = "xfce";
    };
  };
  programs.thunar.enable = true;

  environment.systemPackages = [ ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
