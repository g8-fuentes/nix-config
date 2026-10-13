{ pkgs, ... }:

{
  environment = {
    systemPackages =
      with pkgs;
      [
        gnome-tweaks
        wl-clipboard
      ]
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        caffeine
        color-picker
      ]);

    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
papers
    ];
  };

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      core-apps.enable = true;
      gnome-browser-connector.enable = true;
      gnome-keyring.enable = true;
    };
    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
}
