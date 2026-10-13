{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
    wine
    wine64
  ];
  hardware.graphics.enable32Bit = true;

}
