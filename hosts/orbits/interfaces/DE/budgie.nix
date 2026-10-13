{ ... }: {
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.desktopManager.budgie.extraPlugins = [ ];
  environment.budgie.excludePackages = [ ];
}
