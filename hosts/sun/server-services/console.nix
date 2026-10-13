{ pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "Lat2-Terminus32";

    packages = with pkgs; [ terminus_font ];
  };
}
