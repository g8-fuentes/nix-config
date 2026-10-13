{ config, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.qtile = {
      enable = true;
      backend = "x11";
    };
  };
}
