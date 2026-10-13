{ pkgs, lib, ... }:
let icon = ./davinci-resolve-icon.png;
in {

  home.packages = [ pkgs.davinci-resolve ];
  xdg.desktopEntries."davinci-resolve" = {
    exec =
      "env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia ${pkgs.davinci-resolve}/bin/davinci-resolve";

    genericName = "DaVinci Resolve";
    name = "Davinci Resolve";
    terminal = false;
    startupNotify = true;
    icon = icon;
    mimeType = [ "application/x-resolveproj" ];
    type = "Application";
  };
}
