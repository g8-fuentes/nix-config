{ config, ... }: {

  imports = [ ];

  services.xserver = {
    enable = true;
    windowManager.bspwm = { enable = true; };
  };
}
